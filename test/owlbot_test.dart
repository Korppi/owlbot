import 'package:flutter_test/flutter_test.dart';
import 'package:owlbot/models/word.dart';
import 'package:owlbot/services/owlbot.dart';

void main() {
  test('Search for cat and receive correct response', () async {
    // TODO: fix owlbot so it can be tested in codemagic (get token as env?)
    final OwlBot owlBot = OwlBot();
    final Word? word = await owlBot.define('cat');
    expect(word?.word, 'cat');
  });
}
