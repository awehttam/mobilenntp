import 'mime.dart';

class GroupInfo {
  final String name;
  final int high;
  final int low;
  final String postingStatus; // y / n / m
  final int estimatedCount;
  const GroupInfo({
    required this.name,
    required this.high,
    required this.low,
    required this.postingStatus,
    required this.estimatedCount,
  });
  bool get postingAllowed => postingStatus == 'y' || postingStatus == 'm';
}

class GroupState {
  final String name;
  final int count;
  final int low;
  final int high;
  const GroupState({
    required this.name,
    required this.count,
    required this.low,
    required this.high,
  });
}

/// A parsed XOVER/OVER line. The standard order is:
/// number, Subject, From, Date, Message-ID, References, :bytes, :lines
class OverviewRecord {
  final int number;
  final String subject;
  final String from;
  final String date;
  final String messageId;
  final List<String> references;
  final int bytes;
  final int lines;

  const OverviewRecord({
    required this.number,
    required this.subject,
    required this.from,
    required this.date,
    required this.messageId,
    required this.references,
    required this.bytes,
    required this.lines,
  });

  String get decodedSubject => MimeHeader.decode(subject);
  String get decodedFrom => MimeHeader.decode(from);
  String get authorName => MimeHeader.parseAddressName(decodedFrom);
  DateTime? get parsedDate => parseRfc2822Date(date);

  static OverviewRecord? tryParse(String line) {
    final parts = line.split('\t');
    if (parts.length < 6) return null;
    final number = int.tryParse(parts[0]);
    if (number == null) return null;
    final refs = parts[5]
        .trim()
        .split(RegExp(r'\s+'))
        .where((s) => s.startsWith('<') && s.endsWith('>'))
        .toList();
    return OverviewRecord(
      number: number,
      subject: parts[1],
      from: parts[2],
      date: parts[3],
      messageId: parts[4].trim(),
      references: refs,
      bytes: parts.length > 6 ? int.tryParse(_stripField(parts[6])) ?? 0 : 0,
      lines: parts.length > 7 ? int.tryParse(_stripField(parts[7])) ?? 0 : 0,
    );
  }

  static String _stripField(String v) {
    final i = v.indexOf(':');
    return (i >= 0 ? v.substring(i + 1) : v).trim();
  }
}

class RawArticle {
  final Map<String, String> headers;
  final String rawBody;

  RawArticle(this.headers, this.rawBody);

  static Map<String, String> parseHeaders(List<String> lines) {
    final headers = <String, String>{};
    String? currentKey;
    final buf = StringBuffer();
    void commit() {
      final k = currentKey;
      if (k != null) {
        headers[k.toLowerCase()] = buf.toString();
        buf.clear();
      }
    }

    for (final line in lines) {
      if (line.isEmpty) break;
      if ((line.startsWith(' ') || line.startsWith('\t')) && currentKey != null) {
        buf.write(' ');
        buf.write(line.trim());
      } else {
        commit();
        final idx = line.indexOf(':');
        if (idx <= 0) continue;
        currentKey = line.substring(0, idx).trim();
        buf.write(line.substring(idx + 1).trim());
      }
    }
    commit();
    return headers;
  }

  static RawArticle fromLines(List<String> lines) {
    final headerLines = <String>[];
    var i = 0;
    for (; i < lines.length; i++) {
      if (lines[i].isEmpty) {
        i++;
        break;
      }
      headerLines.add(lines[i]);
    }
    final body = lines.sublist(i).join('\n');
    return RawArticle(parseHeaders(headerLines), body);
  }

  /// Decodes the body to text, honoring Content-Transfer-Encoding and charset
  /// from Content-Type. For multipart messages, returns the first text/plain part.
  DecodedBody decodeBody() {
    return MimeBody.decode(
      headers['content-type'] ?? 'text/plain',
      headers['content-transfer-encoding'] ?? '7bit',
      rawBody,
    );
  }
}
