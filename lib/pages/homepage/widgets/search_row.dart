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
            height: 48, // TODO: keep like this or is it possible to have %?
            width: MediaQuery.of(context).size.width -
                20 - // this is padding size (10+10)
                48, // this is iconbutton size
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
