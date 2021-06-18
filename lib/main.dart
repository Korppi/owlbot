import 'package:flutter/material.dart';
import 'package:owlbot/utils/secrets.dart';

Future<void> main() async {
  // because main is async we need this line here
  WidgetsFlutterBinding.ensureInitialized();
  // init Secrects. Reads json and gets token for Owlbot API
  await Secrets.init();
  if (Secrets.getToken() == null) {
    // if there is no token then somethings wrong and we cannot start app
    throw ('no token!');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Owlbot',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Owlbot'),
        ),
        body: Center(
          child: Text('Work in progress'),
        ),
      ),
    );
  }
}
