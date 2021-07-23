import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlbot/pages/homepage/homepage.dart';
import 'package:owlbot/utils/secrets.dart';

Future<void> main() async {
  // because main has stuff going on we need this line here and
  WidgetsFlutterBinding.ensureInitialized();
  // init Secrects. Reads json and gets token for Owlbot API
  await Secrets.init();
  if (Secrets.getToken() == null) {
    // if there is no token then somethings wrong and we cannot start app
    throw ('no token!');
  }
  // ProviderScope is needed for riverpod to work
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Owlbot',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.green),
        ),
      ),
      home: HomePage(),
    );
  }
}
