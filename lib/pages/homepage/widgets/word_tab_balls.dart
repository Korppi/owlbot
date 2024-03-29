import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// This widget builds only the tab balls
class WordTabBalls extends HookWidget {
  final _pageController;
  final _tabController;
  const WordTabBalls(this._pageController, this._tabController, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: 48,
          width: 300,
          child: PageView(
            controller: _pageController,
            children: <Widget>[
              Center(
                child: TabPageSelector(
                  controller: _tabController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
