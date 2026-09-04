import 'package:flutter_test/flutter_test.dart';

import 'package:mobilenntp/logic/threading.dart';

void main() {
  test('replySubject normalizes Re: prefixes', () {
    expect(replySubject('Re: Re: hello'), 'Re: hello');
    expect(replySubject('hello'), 'Re: hello');
  });
}
