import 'package:flutter/material.dart';
// this hooks_riverpod import is needed for context.read() to work!
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlbot/pages/homepage/homepage.dart';

/// Search row containing textfield and iconbutton. Does not change between
/// states.
class SearchRow extends StatelessWidget {
  const SearchRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('searchrow build');
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
              // remember! this need hooks_riverpod import to work!
              context
                  .read(homepageStateNotifierProvider.notifier)
                  .testFunction(); // TODO: add actual function
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
