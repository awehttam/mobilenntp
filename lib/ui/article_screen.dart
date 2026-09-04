import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../logic/threading.dart';
import '../state/providers.dart';
import 'compose_screen.dart';
import 'widgets.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  final Server server;
  final Subscription subscription;
  final int articleId;
  final GroupKey threadKey;

  const ArticleScreen({
    super.key,
    required this.server,
    required this.subscription,
    required this.articleId,
    required this.threadKey,
  });

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  late int _currentId;
  final Map<int, Future<String>> _bodyCache = {};

  @override
  void initState() {
    super.initState();
    _currentId = widget.articleId;
  }

  Future<String> _bodyFor(Article a) {
    return _bodyCache.putIfAbsent(
        a.id, () => ref.read(repositoryProvider).loadBody(a));
  }

  List<Article> _orderedThread(List<Article> all) {
    final roots = buildThreads(all);
    return flattenThreads(roots).map((n) => n.article).toList();
  }

  @override
  Widget build(BuildContext context) {
    final articlesAsync = ref.watch(articlesProvider(widget.threadKey));
    final all = articlesAsync.valueOrNull ?? const [];
    final ordered = _orderedThread(all);
    final article =
        all.where((a) => a.id == _currentId).firstOrNull ?? ordered.firstOrNull;

    if (article == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Article not available')),
      );
    }

    final idx = ordered.indexWhere((a) => a.id == article.id);
    final hasPrev = idx > 0;
    final hasNext = idx >= 0 && idx < ordered.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subscription.groupName,
            overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: Icon(article.isStarred ? Icons.star : Icons.star_border),
            color: article.isStarred ? Colors.amber : null,
            onPressed: () =>
                ref.read(repositoryProvider).toggleStar(article),
          ),
          IconButton(
            icon: Icon(article.isRead
                ? Icons.mark_email_read_outlined
                : Icons.mark_email_unread_outlined),
            onPressed: () => ref
                .read(repositoryProvider)
                .markRead(article, !article.isRead),
          ),
          PopupMenuButton<String>(
            onSelected: (v) => _onMenu(v, article),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'copyid', child: Text('Copy Message-ID')),
              PopupMenuItem(value: 'reload', child: Text('Reload from server')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  article.subject.isEmpty ? '(no subject)' : article.subject,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                _HeaderLine(label: 'From', value: article.fromRaw),
                if (article.date != null)
                  _HeaderLine(
                      label: 'Date', value: formatFull(article.date!)),
                _HeaderLine(
                    label: 'Article',
                    value: '#${article.number}  ·  ${article.lines} lines'),
                const Divider(height: 24),
                FutureBuilder<String>(
                  future: _bodyFor(article),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (snap.hasError) {
                      return ErrorBanner(
                        message: 'Could not load body: ${snap.error}',
                        onRetry: () => setState(
                            () => _bodyCache.remove(article.id)),
                      );
                    }
                    return _BodyText(text: snap.data ?? '');
                  },
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up),
                  tooltip: 'Previous in thread',
                  onPressed: hasPrev
                      ? () => setState(
                          () => _currentId = ordered[idx - 1].id)
                      : null,
                ),
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  tooltip: 'Next in thread',
                  onPressed: hasNext
                      ? () => setState(
                          () => _currentId = ordered[idx + 1].id)
                      : null,
                ),
                const Spacer(),
                TextButton.icon(
                  icon: const Icon(Icons.reply),
                  label: const Text('Reply'),
                  onPressed: () => _reply(article),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _reply(Article article) async {
    final body = await _bodyFor(article).catchError((_) => '');
    if (!mounted) return;
    final refs = article.references
        .split(RegExp(r'\s+'))
        .where((s) => s.isNotEmpty)
        .toList()
      ..add(article.messageId);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ComposeScreen(
        server: widget.server,
        newsgroup: widget.subscription.groupName,
        subject: replySubject(article.subject),
        quotedBody: quoteBody(body, article.authorName),
        references: refs,
      ),
    ));
  }

  void _onMenu(String value, Article article) {
    switch (value) {
      case 'copyid':
        Clipboard.setData(ClipboardData(text: article.messageId));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Message-ID copied')));
      case 'reload':
        setState(() => _bodyCache.remove(article.id));
        _bodyCache[article.id] =
            ref.read(repositoryProvider).loadBody(article, force: true);
        setState(() {});
    }
  }
}

class _HeaderLine extends StatelessWidget {
  final String label;
  final String value;
  const _HeaderLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodySmall,
          children: [
            TextSpan(
                text: '$label:  ',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.outline)),
            TextSpan(
                text: value,
                style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize:
                        Theme.of(context).textTheme.bodySmall?.fontSize)),
          ],
        ),
      ),
    );
  }
}

/// Renders plain-text article bodies with quote-level coloring and clickable
/// signatures separated visually.
class _BodyText extends StatelessWidget {
  final String text;
  const _BodyText({required this.text});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final quoteColors = [
      scheme.primary,
      scheme.tertiary,
      scheme.secondary,
    ];
    final lines = text.replaceAll('\r\n', '\n').split('\n');
    final spans = <TextSpan>[];
    var inSignature = false;
    for (final line in lines) {
      if (line == '-- ') inSignature = true;
      var quoteLevel = 0;
      var i = 0;
      while (i < line.length && (line[i] == '>' || line[i] == ' ')) {
        if (line[i] == '>') quoteLevel++;
        i++;
      }
      final color = inSignature
          ? scheme.outline
          : quoteLevel == 0
              ? null
              : quoteColors[(quoteLevel - 1) % quoteColors.length];
      spans.add(TextSpan(
        text: '$line\n',
        style: TextStyle(
          color: color,
          fontStyle: inSignature ? FontStyle.italic : FontStyle.normal,
        ),
      ));
    }
    return SelectableText.rich(
      TextSpan(
        style: const TextStyle(
            fontFamily: 'monospace', fontSize: 13.5, height: 1.4),
        children: spans,
      ),
    );
  }
}
