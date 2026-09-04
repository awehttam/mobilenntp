import '../data/database.dart';

/// A node in a threaded article tree.
class ThreadNode {
  final Article article;
  final List<ThreadNode> children = [];
  int depth = 0;
  ThreadNode(this.article);

  int get totalCount =>
      1 + children.fold(0, (sum, c) => sum + c.totalCount);
  int get unreadCount =>
      (article.isRead ? 0 : 1) +
      children.fold(0, (sum, c) => sum + c.unreadCount);
  DateTime get latestDate {
    var latest = article.date ?? DateTime.fromMillisecondsSinceEpoch(0);
    for (final c in children) {
      final d = c.latestDate;
      if (d.isAfter(latest)) latest = d;
    }
    return latest;
  }
}

/// Builds threads from a flat list of articles using References / Message-ID,
/// a simplified version of Jamie Zawinski's threading algorithm.
List<ThreadNode> buildThreads(List<Article> articles) {
  final nodes = <String, ThreadNode>{};
  final orphanParents = <String, ThreadNode>{};

  ThreadNode nodeFor(Article a) =>
      nodes.putIfAbsent(a.messageId, () => ThreadNode(a));

  ThreadNode placeholderFor(String id) => nodes.putIfAbsent(
        id,
        () => orphanParents[id] ??= ThreadNode(
          Article(
            id: -1,
            serverId: -1,
            groupName: '',
            number: -1,
            messageId: id,
            subject: '',
            fromRaw: '',
            authorName: '',
            date: null,
            references: '',
            bytes: 0,
            lines: 0,
            isRead: true,
            isStarred: false,
            bodyText: null,
            bodyFetchedAt: null,
          ),
        ),
      );

  for (final a in articles) {
    final node = nodeFor(a);
    final refs = a.references
        .split(RegExp(r'\s+'))
        .where((s) => s.startsWith('<') && s.endsWith('>'))
        .toList();

    // Link the reference chain together.
    ThreadNode? parent;
    for (final ref in refs) {
      final refNode = placeholderFor(ref);
      if (parent != null &&
          !parent.children.contains(refNode) &&
          !_isAncestor(refNode, parent)) {
        parent.children.add(refNode);
      }
      parent = refNode;
    }
    if (parent != null && !_isAncestor(node, parent)) {
      // Detach from any previous parent first.
      for (final n in nodes.values) {
        n.children.remove(node);
      }
      if (!parent.children.contains(node)) parent.children.add(node);
    }
  }

  // Roots: nodes that are nobody's child.
  final childIds = <String>{};
  for (final n in nodes.values) {
    for (final c in n.children) {
      childIds.add(c.article.messageId);
    }
  }
  final roots = nodes.values
      .where((n) => !childIds.contains(n.article.messageId))
      .toList();

  // Drop pure-placeholder roots with a single real child (promote the child).
  final result = <ThreadNode>[];
  for (var root in roots) {
    while (root.article.id == -1 && root.children.length == 1) {
      root = root.children.first;
    }
    if (root.article.id == -1 && root.children.isEmpty) continue;
    _assignDepth(root, 0);
    _sortTree(root);
    result.add(root);
  }
  result.sort((a, b) => b.latestDate.compareTo(a.latestDate));
  return result;
}

bool _isAncestor(ThreadNode candidate, ThreadNode node) {
  if (identical(candidate, node)) return true;
  for (final c in candidate.children) {
    if (_isAncestor(c, node)) return true;
  }
  return false;
}

void _assignDepth(ThreadNode node, int depth) {
  node.depth = depth;
  for (final c in node.children) {
    _assignDepth(c, depth + 1);
  }
}

void _sortTree(ThreadNode node) {
  node.children.sort((a, b) {
    final da = a.article.date, dbb = b.article.date;
    if (da != null && dbb != null) return da.compareTo(dbb);
    return a.article.number.compareTo(b.article.number);
  });
  for (final c in node.children) {
    _sortTree(c);
  }
}

/// Flattens a thread tree depth-first for list display.
List<ThreadNode> flattenThreads(List<ThreadNode> roots) {
  final out = <ThreadNode>[];
  void visit(ThreadNode n) {
    if (n.article.id != -1) out.add(n);
    for (final c in n.children) {
      visit(c);
    }
  }

  for (final r in roots) {
    visit(r);
  }
  return out;
}

/// Builds a quoted reply body from the original text.
String quoteBody(String original, String authorName) {
  final quoted = original
      .trimRight()
      .split(RegExp(r'\r?\n'))
      .map((l) => l.startsWith('>') ? '>$l' : '> $l')
      .join('\n');
  final attribution =
      authorName.isEmpty ? 'Previously wrote:' : '$authorName wrote:';
  return '$attribution\n\n$quoted\n\n';
}

/// Strips leading Re: prefixes and adds a single one.
String replySubject(String subject) {
  final base = subject.replaceFirst(RegExp(r'^(\s*re:\s*)+', caseSensitive: false), '');
  return 'Re: $base';
}
