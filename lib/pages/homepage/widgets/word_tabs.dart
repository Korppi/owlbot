import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:owlbot/models/definition.dart';
import 'package:owlbot/models/word.dart';
import 'package:url_launcher/url_launcher.dart';

class WordTabs extends HookWidget {
  final Word _word;
  const WordTabs(this._word, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final tabController = useTabController(
        initialLength: _word.definitions.length,
        vsync: useSingleTickerProvider());
    return Expanded(
      child: ListView(
        // TODO: keep as it is or change column here?
        children: [
          _buildTabBalls(pageController, tabController),
          SizedBox(
            width: 200,
            height: 395,
            child: TabBarView(
              controller: tabController,
              children: _buildTabs(),
            ),
          ),
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
                              Text(_word.pronunciation ??
                                  ''), // TODO: check this... i think this shows weird characters (example: wrinkles)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 32,
                thickness: 2,
                indent: 40,
                endIndent: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left:
                        32.0), // TODO: this might not work with all devices...
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
                        Text(def.example ??
                            ''), // TODO: check long examples (owl)
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 32,
                thickness: 2,
                indent: 40,
                endIndent: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left:
                        32.0), // TODO: this might not work with all devices...
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
                        Text(
                          def.definition,
                        ), // TODO: check long examples (owl)
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 32,
                thickness: 2,
                indent: 40,
                endIndent: 200,
              ),
              def.emoji != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(utf8.decode(def.emoji!.runes.toList())),
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
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: def.imageUrl != null
          ? GestureDetector(
              onTap: () async => await canLaunch(def.imageUrl!)
                  ? await launch(def.imageUrl!)
                  : debugPrint(
                      'cannot open url!'), // ? show some error to user?
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(def.imageUrl!),
              ),
            )
          : Icon(
              Icons.flutter_dash,
              size: 140,
            ),
    );
  }
}
