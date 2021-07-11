import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:owlbot/models/word.dart';

class WordTabs extends HookWidget {
  final Word _word;
  const WordTabs(this._word, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final tabController = useTabController(
        initialLength: 3, // _word.definitions.length,
        vsync: useSingleTickerProvider());
    return Expanded(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 48,
                width: 300,
                child: PageView(
                  controller: pageController,
                  children: <Widget>[
                    Center(
                      child: TabPageSelector(
                        controller: tabController,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 200,
            height: 390,
            child: Container(
              color: Colors.amber,
              child: TabBarView(
                controller: tabController,
                children: [
                  Text('ABC'),
                  Text('DEF'),
                  Text('GHI'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
