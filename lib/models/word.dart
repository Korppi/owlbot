import 'package:owlbot/models/definition.dart';

class Word {
  // this is what we were looking (example: cat)
  final String word;
  // pronunciation for word and can be null (null example: cat)
  final String? pronunciation;
  // list of one or more definitions (multiple def example: sun)
  final List<Definition> definitions;

  Word._(this.word, this.pronunciation, this.definitions);

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word._(
        json['word'],
        json['pronunciation'],
        List<Definition>.from(
            json['definitions'].map((v) => Definition.fromJson(v))));
  }
}
