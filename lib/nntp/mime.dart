import 'dart:convert';
import 'dart:typed_data';

import 'package:charset/charset.dart';

/// Decodes RFC 2047 encoded-words in header values, e.g.
/// `=?UTF-8?B?...?=` and `=?ISO-8859-1?Q?...?=`.
class MimeHeader {
  static final _encodedWord =
      RegExp(r'=\?([^?]+)\?([bBqQ])\?([^?]*)\?=', caseSensitive: false);

  static String decode(String input) {
    if (!input.contains('=?')) return input.trim();
    final out = StringBuffer();
    var last = 0;
    var prevWasEncoded = false;
    for (final m in _encodedWord.allMatches(input)) {
      final between = input.substring(last, m.start);
      // Whitespace between two adjacent encoded words is dropped per RFC 2047.
      if (!(prevWasEncoded && between.trim().isEmpty)) {
        out.write(between);
      }
      prevWasEncoded = true;
      final charsetName = m.group(1)!;
      final enc = m.group(2)!.toUpperCase();
      final data = m.group(3)!;
      Uint8List bytes;
      try {
        if (enc == 'B') {
          bytes = base64.decode(_padBase64(data.replaceAll(' ', '')));
        } else {
          bytes = _decodeQ(data);
        }
        out.write(_decodeCharset(charsetName, bytes));
      } catch (_) {
        out.write(m.group(0));
      }
      last = m.end;
    }
    out.write(input.substring(last));
    return out.toString().trim();
  }

  static Uint8List _decodeQ(String s) {
    final bytes = <int>[];
    for (var i = 0; i < s.length; i++) {
      final c = s[i];
      if (c == '_') {
        bytes.add(0x20);
      } else if (c == '=' && i + 2 < s.length) {
        final hex = s.substring(i + 1, i + 3);
        final v = int.tryParse(hex, radix: 16);
        if (v != null) {
          bytes.add(v);
          i += 2;
        } else {
          bytes.add(c.codeUnitAt(0));
        }
      } else {
        bytes.add(c.codeUnitAt(0));
      }
    }
    return Uint8List.fromList(bytes);
  }

  /// Extracts the display name from a `Name <addr@host>` or `addr (Name)` value.
  static String parseAddressName(String from) {
    var s = from.trim();
    final angle = RegExp(r'^(.*?)<([^>]+)>\s*$').firstMatch(s);
    if (angle != null) {
      var name = angle.group(1)!.trim();
      name = _unquote(name);
      return name.isNotEmpty ? name : angle.group(2)!.trim();
    }
    final paren = RegExp(r'^(\S+)\s*\((.*)\)\s*$').firstMatch(s);
    if (paren != null) return paren.group(2)!.trim();
    return s;
  }

  static String _unquote(String s) {
    if (s.length >= 2 && s.startsWith('"') && s.endsWith('"')) {
      return s.substring(1, s.length - 1).replaceAll(r'\"', '"');
    }
    return s;
  }
}

String _padBase64(String s) {
  final mod = s.length % 4;
  if (mod == 0) return s;
  return s + '=' * (4 - mod);
}

String _decodeCharset(String name, List<int> bytes) {
  final n = name.toLowerCase().trim();
  try {
    if (n == 'utf-8' || n == 'utf8' || n == 'us-ascii' || n == 'ascii') {
      return utf8.decode(bytes, allowMalformed: true);
    }
    if (n == 'iso-8859-1' || n == 'latin1' || n == 'iso8859-1') {
      return latin1.decode(bytes, allowInvalid: true);
    }
    final codec = Charset.getByName(n);
    if (codec != null) return codec.decode(bytes);
  } catch (_) {}
  return utf8.decode(bytes, allowMalformed: true);
}

class DecodedBody {
  final String text;
  final String charset;
  final bool isHtml;
  const DecodedBody(this.text, this.charset, {this.isHtml = false});
}

class MimeBody {
  static DecodedBody decode(
    String contentType,
    String transferEncoding,
    String rawBody,
  ) {
    final ct = _parseContentType(contentType);
    if (ct.mediaType.startsWith('multipart/')) {
      final boundary = ct.params['boundary'];
      if (boundary != null) {
        final part = _firstTextPart(rawBody, boundary);
        if (part != null) return part;
      }
    }
    final bytes = _applyTransferEncoding(transferEncoding, rawBody);
    final charsetName = ct.params['charset'] ?? 'utf-8';
    return DecodedBody(
      _decodeCharset(charsetName, bytes),
      charsetName,
      isHtml: ct.mediaType == 'text/html',
    );
  }

  static DecodedBody? _firstTextPart(String body, String boundary) {
    final delimiter = '--$boundary';
    final segments = body.split(delimiter);
    DecodedBody? htmlFallback;
    for (final seg in segments) {
      final trimmed = seg.trimLeft();
      if (trimmed.isEmpty || trimmed.startsWith('--')) continue;
      final sepIdx = _headerBodySplit(seg);
      if (sepIdx < 0) continue;
      final headerBlock = seg.substring(0, sepIdx);
      final partBody = seg.substring(sepIdx).replaceFirst(RegExp(r'^\r?\n\r?\n'), '');
      final headers = _parsePartHeaders(headerBlock);
      final ct = _parseContentType(headers['content-type'] ?? 'text/plain');
      final cte = headers['content-transfer-encoding'] ?? '7bit';
      if (ct.mediaType.startsWith('multipart/')) {
        final inner = ct.params['boundary'];
        if (inner != null) {
          final nested = _firstTextPart(partBody, inner);
          if (nested != null && !nested.isHtml) return nested;
          htmlFallback ??= nested;
        }
        continue;
      }
      final bytes = _applyTransferEncoding(cte, partBody);
      final charsetName = ct.params['charset'] ?? 'utf-8';
      final decoded = DecodedBody(
        _decodeCharset(charsetName, bytes),
        charsetName,
        isHtml: ct.mediaType == 'text/html',
      );
      if (ct.mediaType == 'text/plain') return decoded;
      if (ct.mediaType == 'text/html') htmlFallback ??= decoded;
    }
    return htmlFallback;
  }

  static int _headerBodySplit(String seg) {
    final rn = seg.indexOf('\r\n\r\n');
    final nn = seg.indexOf('\n\n');
    if (rn < 0) return nn < 0 ? -1 : nn;
    if (nn < 0) return rn;
    return rn < nn ? rn : nn;
  }

  static Map<String, String> _parsePartHeaders(String block) {
    final out = <String, String>{};
    String? key;
    final buf = StringBuffer();
    void commit() {
      final k = key;
      if (k != null) out[k.toLowerCase()] = buf.toString();
      buf.clear();
    }

    for (final line in const LineSplitter().convert(block)) {
      if (line.startsWith(' ') || line.startsWith('\t')) {
        buf.write(' ');
        buf.write(line.trim());
      } else {
        commit();
        final i = line.indexOf(':');
        if (i <= 0) {
          key = null;
          continue;
        }
        key = line.substring(0, i).trim();
        buf.write(line.substring(i + 1).trim());
      }
    }
    commit();
    return out;
  }

  static Uint8List _applyTransferEncoding(String encoding, String body) {
    switch (encoding.toLowerCase().trim()) {
      case 'base64':
        final clean = body.replaceAll(RegExp(r'\s'), '');
        try {
          return base64.decode(_padBase64(clean));
        } catch (_) {
          return Uint8List.fromList(latin1.encode(body));
        }
      case 'quoted-printable':
        return _decodeQuotedPrintable(body);
      default:
        return Uint8List.fromList(latin1.encode(body));
    }
  }

  static Uint8List _decodeQuotedPrintable(String body) {
    final out = <int>[];
    final lines = body.split(RegExp(r'\r?\n'));
    for (var li = 0; li < lines.length; li++) {
      var line = lines[li];
      var softBreak = false;
      if (line.endsWith('=')) {
        line = line.substring(0, line.length - 1);
        softBreak = true;
      }
      for (var i = 0; i < line.length; i++) {
        final c = line[i];
        if (c == '=' && i + 3 <= line.length) {
          final hex = line.substring(i + 1, i + 3);
          final v = int.tryParse(hex, radix: 16);
          if (v != null) {
            out.add(v);
            i += 2;
            continue;
          }
        }
        out.add(c.codeUnitAt(0) & 0xFF);
      }
      if (!softBreak && li != lines.length - 1) {
        out.add(0x0A);
      }
    }
    return Uint8List.fromList(out);
  }
}

class _ContentType {
  final String mediaType;
  final Map<String, String> params;
  _ContentType(this.mediaType, this.params);
}

_ContentType _parseContentType(String value) {
  final parts = value.split(';');
  final mediaType = parts.first.trim().toLowerCase();
  final params = <String, String>{};
  for (final p in parts.skip(1)) {
    final i = p.indexOf('=');
    if (i < 0) continue;
    final k = p.substring(0, i).trim().toLowerCase();
    var v = p.substring(i + 1).trim();
    if (v.length >= 2 && v.startsWith('"') && v.endsWith('"')) {
      v = v.substring(1, v.length - 1);
    }
    params[k] = v;
  }
  return _ContentType(mediaType, params);
}

/// Parses an RFC 2822 / RFC 5322 Date header. Returns null on failure.
DateTime? parseRfc2822Date(String input) {
  var s = input.trim();
  // Strip leading day-of-week.
  s = s.replaceFirst(RegExp(r'^[A-Za-z]{3},\s*'), '');
  final m = RegExp(
    r'^(\d{1,2})\s+([A-Za-z]{3})\s+(\d{2,4})\s+(\d{1,2}):(\d{2})(?::(\d{2}))?\s*([+-]\d{4}|[A-Za-z]+)?',
  ).firstMatch(s);
  if (m == null) return null;
  const months = {
    'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
    'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12,
  };
  final day = int.parse(m.group(1)!);
  final month = months[m.group(2)!.toLowerCase()];
  if (month == null) return null;
  var year = int.parse(m.group(3)!);
  if (year < 100) year += year < 70 ? 2000 : 1900;
  final hour = int.parse(m.group(4)!);
  final minute = int.parse(m.group(5)!);
  final second = int.tryParse(m.group(6) ?? '0') ?? 0;
  var offsetMinutes = 0;
  final tz = m.group(7);
  if (tz != null && RegExp(r'^[+-]\d{4}$').hasMatch(tz)) {
    final sign = tz[0] == '-' ? -1 : 1;
    offsetMinutes =
        sign * (int.parse(tz.substring(1, 3)) * 60 + int.parse(tz.substring(3)));
  }
  final utc = DateTime.utc(year, month, day, hour, minute, second)
      .subtract(Duration(minutes: offsetMinutes));
  return utc.toLocal();
}
