import 'package:flutter_test/flutter_test.dart';
import 'package:mobilenntp/data/database.dart';
import 'package:mobilenntp/logic/threading.dart';

Article _a(int n, String id, String refs) => Article(
      id: n,
      serverId: 1,
      groupName: 'g',
      number: n,
      messageId: id,
      subject: 's',
      fromRaw: 'x',
      authorName: 'x',
      date: DateTime(2025, 1, n),
      references: refs,
      bytes: 0,
      lines: 0,
      isRead: false,
      isStarred: false,
      bodyText: null,
      bodyFetchedAt: null,
    );

void main() {
  test('builds a parent/child thread from References', () {
    final roots = buildThreads([
      _a(1, '<1>', ''),
      _a(2, '<2>', '<1>'),
      _a(3, '<3>', '<1> <2>'),
    ]);
    expect(roots.length, 1);
    final flat = flattenThreads(roots);
    expect(flat.map((n) => n.article.number), [1, 2, 3]);
    expect(flat[1].depth, 1);
    expect(flat[2].depth, 2);
    expect(roots.first.totalCount, 3);
  });

  test('separate threads stay separate', () {
    final roots = buildThreads([
      _a(1, '<1>', ''),
      _a(2, '<2>', ''),
    ]);
    expect(roots.length, 2);
  });

  test('missing parent still groups replies', () {
    final roots = buildThreads([
      _a(2, '<2>', '<missing>'),
      _a(3, '<3>', '<missing>'),
    ]);
    expect(roots.length, 1);
    expect(flattenThreads(roots).length, 2);
  });
}
