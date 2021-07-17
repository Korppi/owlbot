import 'dart:convert';

import 'package:owlbot/models/word.dart';
import 'package:http/http.dart' as http;

/// Owlbot wrapper for Owlbot API
class OwlBot {
  final String _token;
  final http.Client client;
  // API has only 1 API thing (v4/dict...) so we use it as baseurl
  final String _baseurl = 'https://owlbot.info/api/v4/dictionary/';

  OwlBot(this._token, {http.Client? client})
      : this.client = client ?? http.Client();

  /// Returns Word object with definitions or null if word is not found
  Future<Word?> define(String word) async {
    Uri url = Uri.parse(_baseurl + word);
    http.Response response =
        await client.get(url, headers: {'Authorization': 'Token ' + _token});
    if (response.statusCode == 200) {
      // everything OK, create Word object and return it
      return Word.fromJson(jsonDecode(response.body));
    }
    // if statuscode is not 200, then return null
    return null;
  }
}
