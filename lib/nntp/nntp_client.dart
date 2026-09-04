import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'nntp_models.dart';

/// Thrown when the server returns a response code that indicates failure.
class NntpException implements Exception {
  final int code;
  final String message;
  NntpException(this.code, this.message);
  @override
  String toString() => 'NntpException($code): $message';
}

class NntpAuthException extends NntpException {
  NntpAuthException(super.code, super.message);
}

/// A single NNTP response line: `200 message text`.
class NntpResponse {
  final int code;
  final String text;
  NntpResponse(this.code, this.text);
  bool get isOk => code >= 100 && code < 400;
}

/// Configuration for connecting to one news server.
class NntpServerConfig {
  final String host;
  final int port;
  final bool useTls;
  final bool allowBadCertificate;
  final String? username;
  final String? password;

  const NntpServerConfig({
    required this.host,
    this.port = 119,
    this.useTls = false,
    this.allowBadCertificate = false,
    this.username,
    this.password,
  });
}

/// A low-level, single-socket NNTP (RFC 3977) client focused on reading and
/// posting text articles. Not safe for concurrent commands — issue one command
/// at a time (see [NntpConnectionPool] for a higher-level wrapper).
class NntpClient {
  final NntpServerConfig config;
  final Duration timeout;

  Socket? _socket;
  late StreamQueue<String> _lines;
  bool _readerModeEnabled = false;
  bool _authenticated = false;
  String? _currentGroup;

  NntpClient(this.config, {this.timeout = const Duration(seconds: 30)});

  bool get isConnected => _socket != null;
  String? get currentGroup => _currentGroup;

  Future<void> connect() async {
    if (_socket != null) return;
    final Socket socket;
    if (config.useTls) {
      socket = await SecureSocket.connect(
        config.host,
        config.port,
        timeout: timeout,
        onBadCertificate: (_) => config.allowBadCertificate,
      );
    } else {
      socket = await Socket.connect(config.host, config.port, timeout: timeout);
    }
    _socket = socket;
    socket.setOption(SocketOption.tcpNoDelay, true);
    _lines = StreamQueue<String>(
      socket
          .cast<List<int>>()
          .transform(const Latin1Decoder(allowInvalid: true))
          .transform(const LineSplitter()),
    );

    final greeting = await _readResponse();
    if (greeting.code != 200 && greeting.code != 201) {
      await close();
      throw NntpException(greeting.code, 'Unexpected greeting: ${greeting.text}');
    }
    // 201 = no posting allowed; still usable for reading.
  }

  Future<void> close() async {
    final s = _socket;
    _socket = null;
    _readerModeEnabled = false;
    _authenticated = false;
    _currentGroup = null;
    if (s != null) {
      try {
        s.write('QUIT\r\n');
        await s.flush().timeout(const Duration(seconds: 2));
      } catch (_) {}
      try {
        await _lines.cancel(immediate: true);
      } catch (_) {}
      s.destroy();
    }
  }

  Future<NntpResponse> _readResponse() async {
    final line = await _lines.next.timeout(timeout);
    if (line.length < 3) throw NntpException(-1, 'Malformed response: "$line"');
    final code = int.tryParse(line.substring(0, 3));
    if (code == null) throw NntpException(-1, 'Malformed response: "$line"');
    final text = line.length > 4 ? line.substring(4) : '';
    return NntpResponse(code, text);
  }

  void _write(String command) {
    final s = _socket;
    if (s == null) throw NntpException(-1, 'Not connected');
    s.write('$command\r\n');
  }

  /// Sends [command] and returns the status line. Does not read any following
  /// multi-line block.
  Future<NntpResponse> sendCommand(String command, {bool retryAuth = true}) async {
    await connect();
    _write(command);
    await _socket!.flush();
    var resp = await _readResponse();
    if ((resp.code == 480) && retryAuth) {
      await _authenticate();
      _write(command);
      await _socket!.flush();
      resp = await _readResponse();
    }
    return resp;
  }

  /// Reads a dot-terminated multi-line block (already past the status line).
  Future<List<String>> _readMultiline() async {
    final out = <String>[];
    while (true) {
      final line = await _lines.next.timeout(timeout);
      if (line == '.') break;
      // Dot-stuffing: a leading '.' is doubled by the server.
      out.add(line.startsWith('.') ? line.substring(1) : line);
    }
    return out;
  }

  Future<void> ensureReaderMode() async {
    if (_readerModeEnabled) return;
    final resp = await sendCommand('MODE READER', retryAuth: false);
    // 200/201 ok; 500 (unknown command) tolerated for reader-only servers.
    if (resp.code != 200 && resp.code != 201 && resp.code != 500) {
      throw NntpException(resp.code, 'MODE READER failed: ${resp.text}');
    }
    _readerModeEnabled = true;
    if (config.username != null && config.username!.isNotEmpty) {
      await _authenticate();
    }
  }

  Future<void> _authenticate() async {
    if (_authenticated) return;
    final user = config.username;
    final pass = config.password;
    if (user == null || user.isEmpty) {
      throw NntpAuthException(480, 'Server requires authentication');
    }
    _write('AUTHINFO USER $user');
    await _socket!.flush();
    var resp = await _readResponse();
    if (resp.code == 381) {
      _write('AUTHINFO PASS ${pass ?? ''}');
      await _socket!.flush();
      resp = await _readResponse();
    }
    if (resp.code != 281) {
      throw NntpAuthException(resp.code, 'Authentication failed: ${resp.text}');
    }
    _authenticated = true;
  }

  /// LIST ACTIVE — all groups with article counts.
  Future<List<GroupInfo>> listActive({String? wildmat}) async {
    await ensureReaderMode();
    final resp = await sendCommand(
      wildmat == null ? 'LIST ACTIVE' : 'LIST ACTIVE $wildmat',
    );
    if (resp.code != 215) {
      throw NntpException(resp.code, 'LIST ACTIVE failed: ${resp.text}');
    }
    final lines = await _readMultiline();
    final groups = <GroupInfo>[];
    for (final l in lines) {
      final parts = l.split(RegExp(r'\s+'));
      if (parts.length < 4) continue;
      final high = int.tryParse(parts[1]) ?? 0;
      final low = int.tryParse(parts[2]) ?? 0;
      groups.add(GroupInfo(
        name: parts[0],
        high: high,
        low: low,
        postingStatus: parts[3],
        estimatedCount: (high - low + 1).clamp(0, 1 << 62),
      ));
    }
    return groups;
  }

  /// LIST NEWSGROUPS — group descriptions.
  Future<Map<String, String>> listDescriptions({String? wildmat}) async {
    await ensureReaderMode();
    final resp = await sendCommand(
      wildmat == null ? 'LIST NEWSGROUPS' : 'LIST NEWSGROUPS $wildmat',
    );
    if (resp.code != 215) return {};
    final lines = await _readMultiline();
    final out = <String, String>{};
    for (final l in lines) {
      final m = RegExp(r'^(\S+)\s+(.*)$').firstMatch(l);
      if (m != null) out[m.group(1)!] = m.group(2)!.trim();
    }
    return out;
  }

  /// GROUP — select a group, returns its current estimate/low/high.
  Future<GroupState> selectGroup(String name) async {
    await ensureReaderMode();
    final resp = await sendCommand('GROUP $name');
    if (resp.code != 211) {
      throw NntpException(resp.code, 'GROUP failed: ${resp.text}');
    }
    final parts = resp.text.split(RegExp(r'\s+'));
    _currentGroup = name;
    return GroupState(
      name: name,
      count: int.tryParse(parts[0]) ?? 0,
      low: int.tryParse(parts[1]) ?? 0,
      high: int.tryParse(parts[2]) ?? 0,
    );
  }

  /// XOVER/OVER for a range. Returns parsed overview records.
  Future<List<OverviewRecord>> over(int from, int to) async {
    if (_currentGroup == null) {
      throw NntpException(-1, 'No group selected');
    }
    final range = from == to ? '$from' : '$from-$to';
    var resp = await sendCommand('OVER $range', retryAuth: true);
    if (resp.code == 500 || resp.code == 501) {
      resp = await sendCommand('XOVER $range');
    }
    if (resp.code == 423) return []; // no articles in range
    if (resp.code != 224) {
      throw NntpException(resp.code, 'OVER failed: ${resp.text}');
    }
    final lines = await _readMultiline();
    return lines
        .map(OverviewRecord.tryParse)
        .whereType<OverviewRecord>()
        .toList();
  }

  /// ARTICLE by number or message-id. Returns raw header + body lines.
  Future<RawArticle> fetchArticle(String designator) async {
    final resp = await sendCommand('ARTICLE $designator');
    if (resp.code != 220) {
      throw NntpException(resp.code, 'ARTICLE failed: ${resp.text}');
    }
    final lines = await _readMultiline();
    return RawArticle.fromLines(lines);
  }

  /// HEAD by number or message-id.
  Future<Map<String, String>> fetchHead(String designator) async {
    final resp = await sendCommand('HEAD $designator');
    if (resp.code != 221) {
      throw NntpException(resp.code, 'HEAD failed: ${resp.text}');
    }
    final lines = await _readMultiline();
    return RawArticle.parseHeaders(lines);
  }

  /// NEWGROUPS since [since] (UTC).
  Future<List<String>> newGroups(DateTime since) async {
    await ensureReaderMode();
    final d = since.toUtc();
    final date =
        '${d.year.toString().padLeft(4, '0')}${_pad2(d.month)}${_pad2(d.day)}';
    final time = '${_pad2(d.hour)}${_pad2(d.minute)}${_pad2(d.second)}';
    final resp = await sendCommand('NEWGROUPS $date $time GMT');
    if (resp.code != 231) return [];
    final lines = await _readMultiline();
    return lines
        .map((l) => l.split(RegExp(r'\s+')).first)
        .where((s) => s.isNotEmpty)
        .toList();
  }

  /// Post a complete article. [headers] must include From, Newsgroups, Subject.
  Future<void> post({
    required Map<String, String> headers,
    required String body,
  }) async {
    await ensureReaderMode();
    final resp = await sendCommand('POST');
    if (resp.code == 440) {
      throw NntpException(440, 'Posting not permitted by server');
    }
    if (resp.code != 340) {
      throw NntpException(resp.code, 'POST rejected: ${resp.text}');
    }
    final buf = StringBuffer();
    headers.forEach((k, v) {
      buf.write('$k: ${v.replaceAll('\r', '').replaceAll('\n', ' ')}\r\n');
    });
    buf.write('\r\n');
    for (var line in const LineSplitter().convert(body)) {
      if (line.startsWith('.')) line = '.$line'; // dot-stuffing
      buf.write('$line\r\n');
    }
    buf.write('.\r\n');
    _socket!.write(buf.toString());
    await _socket!.flush();
    final done = await _readResponse();
    if (done.code != 240) {
      throw NntpException(done.code, 'Posting failed: ${done.text}');
    }
  }

  static String _pad2(int n) => n.toString().padLeft(2, '0');
}

/// Minimal single-consumer async queue over a Stream (avoids adding the `async`
/// package just for StreamQueue).
class StreamQueue<T> {
  final StreamIterator<T> _it;
  StreamQueue(Stream<T> source) : _it = StreamIterator<T>(source);

  Future<T> get next async {
    if (!await _it.moveNext()) {
      throw NntpException(-1, 'Connection closed by server');
    }
    return _it.current;
  }

  Future<void> cancel({bool immediate = false}) => _it.cancel();
}
