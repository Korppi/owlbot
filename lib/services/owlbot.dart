import 'package:owlbot/models/word.dart';
import 'package:owlbot/services/owlbot_secrets.dart';

class OwlBot {
  final String _token = OwlBotSecrets.token;
  final String _baseurl = 'https://owlbot.info';

  /// Returns Word object with definitions or null if word is not found
  Future<Word?> define(String word) async {
    return null;
  }
}
