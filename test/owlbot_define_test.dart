import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:owlbot/models/word.dart';
import 'package:owlbot/services/owlbot.dart';

import 'owlbot_define_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('define tests', () {
    /* define() has 2 possible return:
    returns Word if it is succesfull
    returns null if it is not succesfull
    
    so we will test for both of these outcomes
    */

    test('return Word object if http call is succesfull', () async {
      final client = MockClient();
      final String fakeToken = 'i am fake token';
      when(client.get(Uri.parse('https://owlbot.info/api/v4/dictionary/cat'),
          headers: {
            'Authorization': 'Token ' + fakeToken
          })).thenAnswer((_) async => http.Response(
          '{"pronunciation":null,"definitions":[{"type":"noun","definition":"a small domesticated carnivorous mammal with soft fur, a short snout, and retractile claws. It is widely kept as a pet or for catching mice, and many breeds have been developed.","example":"their pet cat","image_url":"https://media.owlbot.info/dictionary/images/aaaaaaaaaaaaaaaaac.jpg.400x400_q85_box-42,0,943,900_crop_detail.jpg","emoji":""}],"word":"cat"}',
          200)); // example json receved with postman (but removed emoji because invalid character)
      final OwlBot owlBot =
          OwlBot(fakeToken, client: client); // * fake token and mockito client

      expect(await owlBot.define('cat'), isA<Word>());
    });

    test('return null object if http call fails', () async {
      final client = MockClient();
      final String fakeToken = 'i am fake token';
      when(client.get(Uri.parse('https://owlbot.info/api/v4/dictionary/cat'),
              headers: {'Authorization': 'Token ' + fakeToken}))
          .thenAnswer((_) async => http.Response(
              '[{"message":"No definition :("}]',
              404)); // example json receved with postman
      final OwlBot owlBot =
          OwlBot(fakeToken, client: client); // * fake token and mockito client

      expect(await owlBot.define('cat'), isNull);
    });
  });
}
