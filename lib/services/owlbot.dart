import 'dart:convert';

import 'package:owlbot/models/word.dart';
import 'package:owlbot/services/owlbot_secrets.dart';
import 'package:http/http.dart' as http;

class OwlBot {
  final String _token = OwlBotSecrets.token;
  // API has only 1 API thing (v4/dict...) so we use it as baseurl
  final String _baseurl = 'https://owlbot.info/api/v4/dictionary/';

  /// Returns Word object with definitions or null if word is not found
  Future<Word?> define(String word) async {
    Uri url = Uri.parse(_baseurl + word);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      // everything OK, create Word object and return it
      return Word.fromJson(jsonDecode(response.body));
    }
    // if statuscode is not 200, then return null
    return null;
  }
}
