import 'package:flutter/material.dart';
import 'package:owlbot/pages/homepage/widgets/search_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Owlbot'),
      ),
      body: ListView(
        children: [
          SearchRow(),
        ],
      ),
    );
  }
}
