import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// this hooks_riverpod import is needed for context.read() to work!
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlbot/pages/homepage/homepage.dart';

/// Search row containing textfield and iconbutton. Does not change between states.
class SearchRow extends HookWidget {
  // hookwidget allows us to have useTextEditingController
  const SearchRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchTextController = useTextEditingController();
    // ? some const stuff here... other possible solutions: static const in class or single constants.dart file?
    const double sizedBoxHeight = 48;
    const int iconButtonSize = 48;
    const double paddingSize = 10.0;
    final int sizedBoxWidth = iconButtonSize +
        (2 *
            paddingSize
                .toInt()); // not actually the width but the width to be removed (padding and iconsize)
    return Padding(
      padding: const EdgeInsets.all(paddingSize),
      child: Row(
        children: [
          SizedBox(
            height: sizedBoxHeight,
            width: MediaQuery.of(context).size.width - sizedBoxWidth,
            child: TextField(
              controller: searchTextController,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Enter word and press search',
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _define(context, searchTextController),
            ),
          ),
          IconButton(
            onPressed: () => _define(context, searchTextController),
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }

  _define(BuildContext context, TextEditingController searchTextController) {
    FocusScope.of(context).unfocus(); // closes keyboard
    context
        .read(homepageStateNotifierProvider.notifier)
        .define(searchTextController.text);
  }
}
