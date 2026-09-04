import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../state/providers.dart';
import 'widgets.dart';

class ComposeScreen extends ConsumerStatefulWidget {
  final Server server;
  final String newsgroup;
  final String? subject;
  final String? quotedBody;
  final List<String> references;

  const ComposeScreen({
    super.key,
    required this.server,
    required this.newsgroup,
    this.subject,
    this.quotedBody,
    this.references = const [],
  });

  @override
  ConsumerState<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends ConsumerState<ComposeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _from;
  late final TextEditingController _newsgroups;
  late final TextEditingController _subject;
  late final TextEditingController _body;
  bool _sending = false;
  String? _error;

  bool get _isReply => widget.references.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _from = TextEditingController(text: _identityFor(widget.server));
    _newsgroups = TextEditingController(text: widget.newsgroup);
    _subject = TextEditingController(text: widget.subject ?? '');
    _body = TextEditingController(text: widget.quotedBody ?? '');
  }

  static String _identityFor(Server s) {
    final email = s.email?.trim() ?? '';
    if (email.isEmpty) return '';
    final name = s.fromName?.trim() ?? '';
    return name.isEmpty ? email : '$name <$email>';
  }

  @override
  void dispose() {
    for (final c in [_from, _newsgroups, _subject, _body]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      await ref.read(repositoryProvider).postArticle(
            serverId: widget.server.id,
            from: _from.text.trim(),
            newsgroups: _newsgroups.text
                .split(',')
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList(),
            subject: _subject.text.trim(),
            body: _body.text,
            references: widget.references,
          );
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Article posted')));
      }
    } catch (e) {
      if (mounted) setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isReply ? 'Reply' : 'New article'),
        actions: [
          _sending
              ? const Padding(
                  padding: EdgeInsets.all(14),
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2)),
                )
              : IconButton(
                  icon: const Icon(Icons.send), onPressed: _send),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_error != null) ...[
              ErrorBanner(message: _error!),
              const SizedBox(height: 12),
            ],
            TextFormField(
              controller: _from,
              decoration: InputDecoration(
                labelText: 'From',
                hintText: 'Your Name <you@example.com>',
                helperText: _identityFor(widget.server).isEmpty
                    ? 'Set an email address in the server settings'
                    : 'From your ${widget.server.name} identity',
                border: const OutlineInputBorder(),
              ),
              autocorrect: false,
              validator: (v) => (v == null || !v.contains('@'))
                  ? 'Enter a valid From address'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _newsgroups,
              decoration: const InputDecoration(
                labelText: 'Newsgroups',
                helperText: 'Comma-separated for cross-posting',
                border: OutlineInputBorder(),
              ),
              autocorrect: false,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _subject,
              decoration: const InputDecoration(
                  labelText: 'Subject', border: OutlineInputBorder()),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _body,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 18,
              minLines: 10,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 13.5),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Write something' : null,
            ),
          ],
        ),
      ),
    );
  }
}
