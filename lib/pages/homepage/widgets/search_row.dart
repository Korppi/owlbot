import 'package:flutter/material.dart';

class SearchRow extends StatelessWidget {
  const SearchRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            height: 50, // TODO: keep like this or is it possible to have %?
            width: 290,
            child: TextField(
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Enter word and press search',
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
          IconButton(
            onPressed: () {
              debugPrint('nothing happens!');
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
