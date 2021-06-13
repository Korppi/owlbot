import 'package:flutter/material.dart';

void main() {
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
      home: Container(),
    );
  }
}
