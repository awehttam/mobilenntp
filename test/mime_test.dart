import 'package:flutter_test/flutter_test.dart';
import 'package:mobilenntp/nntp/mime.dart';
import 'package:mobilenntp/nntp/nntp_models.dart';

void main() {
  group('MimeHeader.decode', () {
    test('decodes base64 encoded-word', () {
      expect(MimeHeader.decode('=?UTF-8?B?w6nDqQ==?='), 'éé');
    });

    test('decodes quoted-printable encoded-word with underscore', () {
      expect(MimeHeader.decode('=?ISO-8859-1?Q?Andr=E9_M=FCller?='),
          'André Müller');
    });

    test('joins adjacent encoded words dropping whitespace', () {
      expect(
        MimeHeader.decode('=?UTF-8?B?SGVsbG8s?= =?UTF-8?B?IHdvcmxk?='),
        'Hello, world',
      );
    });

    test('passes through plain text', () {
      expect(MimeHeader.decode('Just a subject'), 'Just a subject');
    });

    test('parses display name from address', () {
      expect(MimeHeader.parseAddressName('"Jane Doe" <jane@example.com>'),
          'Jane Doe');
      expect(MimeHeader.parseAddressName('bob@example.com (Bob)'), 'Bob');
    });
  });

  group('parseRfc2822Date', () {
    test('parses a standard date with offset', () {
      final d = parseRfc2822Date('Wed, 3 Sep 2025 14:30:00 +0200');
      expect(d!.toUtc(), DateTime.utc(2025, 9, 3, 12, 30));
    });
  });

  group('RawArticle', () {
    test('decodes quoted-printable body with declared charset', () {
      final raw = RawArticle.fromLines([
        'From: a@b.c',
        'Content-Type: text/plain; charset="utf-8"',
        'Content-Transfer-Encoding: quoted-printable',
        '',
        'caf=C3=A9 =',
        'au lait',
      ]);
      expect(raw.decodeBody().text.trim(), 'café au lait');
    });

    test('picks text/plain part from multipart/alternative', () {
      final raw = RawArticle.fromLines([
        'Content-Type: multipart/alternative; boundary="XX"',
        '',
        '--XX',
        'Content-Type: text/plain; charset=us-ascii',
        '',
        'plain version',
        '--XX',
        'Content-Type: text/html',
        '',
        '<p>html version</p>',
        '--XX--',
      ]);
      expect(raw.decodeBody().text.trim(), 'plain version');
    });
  });

  group('OverviewRecord', () {
    test('parses a tab-delimited XOVER line', () {
      final rec = OverviewRecord.tryParse(
        '42\tRe: test\tAlice <a@x.com>\tWed, 3 Sep 2025 10:00:00 +0000\t'
        '<msg2@x.com>\t<msg1@x.com>\t:1234\t:20',
      )!;
      expect(rec.number, 42);
      expect(rec.decodedSubject, 'Re: test');
      expect(rec.references, ['<msg1@x.com>']);
      expect(rec.bytes, 1234);
      expect(rec.lines, 20);
    });
  });
}
