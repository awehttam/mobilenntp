import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../state/providers.dart';

class ServerEditScreen extends ConsumerStatefulWidget {
  final Server? server;
  const ServerEditScreen({super.key, this.server});

  @override
  ConsumerState<ServerEditScreen> createState() => _ServerEditScreenState();
}

class _ServerEditScreenState extends ConsumerState<ServerEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _host;
  late final TextEditingController _port;
  late final TextEditingController _username;
  late final TextEditingController _password;
  late final TextEditingController _fromName;
  late final TextEditingController _email;

  bool _useTls = true;
  bool _allowBadCert = false;
  bool _requiresAuth = false;
  bool _testing = false;
  String? _testResult;
  bool _testOk = false;

  bool get _isEdit => widget.server != null;

  @override
  void initState() {
    super.initState();
    final s = widget.server;
    _name = TextEditingController(text: s?.name ?? '');
    _host = TextEditingController(text: s?.host ?? '');
    _port = TextEditingController(text: (s?.port ?? 563).toString());
    _username = TextEditingController(text: s?.username ?? '');
    _password = TextEditingController();
    _fromName = TextEditingController(text: s?.fromName ?? '');
    _email = TextEditingController(text: s?.email ?? '');
    _useTls = s?.useTls ?? true;
    _allowBadCert = s?.allowBadCertificate ?? false;
    _requiresAuth = s?.requiresAuth ?? false;
    if (_isEdit && _requiresAuth) {
      ref.read(credentialStoreProvider).getPassword(s!.id).then((pw) {
        if (mounted && pw != null) _password.text = pw;
      });
    }
  }

  @override
  void dispose() {
    for (final c in [_name, _host, _port, _username, _password, _fromName, _email]) {
      c.dispose();
    }
    super.dispose();
  }

  Server _buildServer({int id = 0}) {
    return Server(
      id: id,
      name: _name.text.trim(),
      host: _host.text.trim(),
      port: int.tryParse(_port.text.trim()) ?? 119,
      useTls: _useTls,
      allowBadCertificate: _allowBadCert,
      username: _requiresAuth ? _username.text.trim() : null,
      requiresAuth: _requiresAuth,
      fromName: _fromName.text.trim().isEmpty ? null : _fromName.text.trim(),
      email: _email.text.trim().isEmpty ? null : _email.text.trim(),
      sortOrder: widget.server?.sortOrder ?? 0,
    );
  }

  Future<void> _test() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _testing = true;
      _testResult = null;
    });
    try {
      await ref.read(repositoryProvider).testConnection(
            _buildServer(id: widget.server?.id ?? -1),
            _requiresAuth ? _password.text : null,
          );
      setState(() {
        _testOk = true;
        _testResult = 'Connected successfully.';
      });
    } catch (e) {
      setState(() {
        _testOk = false;
        _testResult = 'Failed: $e';
      });
    } finally {
      if (mounted) setState(() => _testing = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = ref.read(databaseProvider);
    final creds = ref.read(credentialStoreProvider);
    if (_isEdit) {
      final updated = _buildServer(id: widget.server!.id);
      await db.updateServer(updated);
      await creds.setPassword(
          updated.id, _requiresAuth ? _password.text : null);
    } else {
      final id = await db.insertServer(ServersCompanion(
        name: Value(_name.text.trim()),
        host: Value(_host.text.trim()),
        port: Value(int.tryParse(_port.text.trim()) ?? 119),
        useTls: Value(_useTls),
        allowBadCertificate: Value(_allowBadCert),
        username: Value(_requiresAuth ? _username.text.trim() : null),
        requiresAuth: Value(_requiresAuth),
        fromName: Value(
            _fromName.text.trim().isEmpty ? null : _fromName.text.trim()),
        email: Value(_email.text.trim().isEmpty ? null : _email.text.trim()),
      ));
      if (_requiresAuth) await creds.setPassword(id, _password.text);
    }
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete server?'),
        content: const Text(
            'This removes the server, its subscriptions and cached articles.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete')),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(nntpServiceProvider).disconnect(widget.server!.id);
    await ref.read(credentialStoreProvider).deletePassword(widget.server!.id);
    await ref.read(databaseProvider).deleteServer(widget.server!.id);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit server' : 'Add server'),
        actions: [
          if (_isEdit)
            IconButton(
                onPressed: _delete, icon: const Icon(Icons.delete_outline)),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                  labelText: 'Display name', border: OutlineInputBorder()),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _host,
              decoration: const InputDecoration(
                  labelText: 'Host', hintText: 'news.example.com',
                  border: OutlineInputBorder()),
              autocorrect: false,
              keyboardType: TextInputType.url,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _port,
              decoration: const InputDecoration(
                  labelText: 'Port', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (v) => int.tryParse(v?.trim() ?? '') == null
                  ? 'Enter a number'
                  : null,
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Use SSL/TLS'),
              subtitle: const Text('Default port 563'),
              value: _useTls,
              onChanged: (v) => setState(() {
                _useTls = v;
                if (v && _port.text == '119') _port.text = '563';
                if (!v && _port.text == '563') _port.text = '119';
              }),
            ),
            if (_useTls)
              CheckboxListTile(
                title: const Text('Allow invalid certificates'),
                dense: true,
                value: _allowBadCert,
                onChanged: (v) => setState(() => _allowBadCert = v ?? false),
              ),
            const SizedBox(height: 16),
            _SectionHeader(
              title: 'Identity',
              subtitle: 'Used in the From header when you post to this server',
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _fromName,
              decoration: const InputDecoration(
                labelText: 'Display name (optional)',
                hintText: 'Jane Doe',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'Email address',
                hintText: 'jane@example.com',
                border: OutlineInputBorder(),
              ),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                final t = v?.trim() ?? '';
                if (t.isEmpty) return 'Required to post articles';
                final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(t);
                return ok ? null : 'Enter a valid email address';
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Requires authentication'),
              value: _requiresAuth,
              onChanged: (v) => setState(() => _requiresAuth = v),
            ),
            if (_requiresAuth) ...[
              const SizedBox(height: 8),
              TextFormField(
                controller: _username,
                decoration: const InputDecoration(
                    labelText: 'Username', border: OutlineInputBorder()),
                autocorrect: false,
                validator: (v) => _requiresAuth && (v == null || v.trim().isEmpty)
                    ? 'Required'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
                obscureText: true,
              ),
            ],
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _testing ? null : _test,
              icon: _testing
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.wifi_tethering),
              label: const Text('Test connection'),
            ),
            if (_testResult != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _testResult!,
                  style: TextStyle(
                      color: _testOk
                          ? Colors.green
                          : Theme.of(context).colorScheme.error),
                ),
              ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary)),
        Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
