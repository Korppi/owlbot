import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:owlbot/models/definition.dart';
import 'package:owlbot/models/word.dart';
import 'package:url_launcher/url_launcher.dart';

// TODO: rename to WordTabBalls
class WordTabs extends HookWidget {
  final Word _word;
  final _pageController;
  final _tabController;
  const WordTabs(this._word, this._pageController, this._tabController,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*final pageController = usePageController();
    final tabController = useTabController(
        initialLength: _word.definitions.length,
        vsync: useSingleTickerProvider());*/
    return Expanded(
      child: ListView(
        // TODO: remove this expanded listview stuff
        children: [
          _buildTabBalls(_pageController, _tabController),
          // TODO: this TabBarView should be its own HookWidget with expanded
          /*SizedBox(
            width: 200,
            height: 660,
            child: TabBarView(
              controller: _tabController,
              children: _buildTabs(),
            ),
          ),*/
        ],
      ),
    );
  }

  _buildTabBalls(PageController pageController, TabController tabController) {
    return Row(
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
    );
  }

  _buildTabs() {
    List<Widget> defcards = [];
    _word.definitions.forEach((def) {
      defcards.add(_buildDefinitionCard(def));
    });
    return defcards;
  }

  _buildDefinitionCard(Definition def) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Card(
        color: Colors.green[200],
        child: Container(
          child: Column(
            children: [
              _buildImage(def),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.title),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Word'), // TODO: styles
                              Text(_word.word + ' (' + def.type + ')'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.record_voice_over),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pronunciation'),
                              Text(_word.pronunciation != null
                                  ? utf8.decode(
                                      _word.pronunciation!.runes.toList())
                                  : ''),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              _buildDivider(),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.format_quote),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Example'),
                        Container(
                          width: 250,
                          child: Text(def.example ?? ''),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildDivider(),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.format_quote),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Definition'),
                        Container(
                          width: 250,
                          child: Text(
                            def.definition,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildDivider(),
              def.emoji != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          utf8.decode(def.emoji!.runes.toList()),
                          style: TextStyle(fontSize: 48),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _buildImage(Definition def) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: def.imageUrl != null
          ? GestureDetector(
              onTap: () async => await canLaunch(def.imageUrl!)
                  ? await launch(def.imageUrl!)
                  : debugPrint(
                      'cannot open url!'), // ? show some error to user?
              child: CircleAvatar(
                radius: 120,
                backgroundImage: NetworkImage(def.imageUrl!),
              ),
            )
          : Icon(
              Icons.flutter_dash,
              size: 240,
            ),
    );
  }

  _buildDivider() {
    return Divider(
      height: 32,
      thickness: 2,
      indent: 40,
      endIndent: 200,
    );
  }
}
