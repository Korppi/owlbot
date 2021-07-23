import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:owlbot/models/definition.dart';
import 'package:owlbot/models/word.dart';
import 'package:url_launcher/url_launcher.dart';

class WordTabs extends HookWidget {
  final Word _word;
  final PageController _pageController;
  final TabController _tabController;

  const WordTabs(this._word, this._pageController, this._tabController,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: Container(
          child: TabBarView(
            children: _buildTabs(),
            controller: _tabController,
          ),
        ),
      ),
    );
  }

  _buildTabs() {
    List<Widget> defcards = [];
    _word.definitions.forEach((def) {
      defcards.add(_buildDefinitionCardNew(def));
    });
    return defcards;
  }

  _buildDefinitionCardNew(Definition def) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 2,
      child: ListView(
        children: [
          _buildImage(def),
          _buildWordAndPronunciationRow(def),
          _buildDivider(),
          _buildExampleRow(def),
          _buildDivider(),
          _builDefinitionRow(def),
          _buildDivider(),
        ],
      ),
    );
  }

  _buildWordAndPronunciationRow(Definition def) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.text_fields),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Word'),
                      Text('${_word.word} (${def.type})'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.record_voice_over),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pronunciation'),
                      Text(_word.pronunciation != null
                          ? utf8.decode(_word.pronunciation!.runes.toList())
                          : ''),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildExampleRow(Definition def) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.format_quote),
            ),
          ],
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
    );
  }

  _builDefinitionRow(Definition def) {
    return Container();
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
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: def.imageUrl != null
          ? GestureDetector(
              onTap: () async => await canLaunch(def.imageUrl!)
                  ? await launch(def.imageUrl!)
                  : debugPrint(
                      'cannot open url!'), // ? show some error to user?
              child: ClipOval(
                clipper: MyClip(),
                child: Image.network(
                  def.imageUrl!,
                  width: 140,
                  height: 140,
                ),
              ),
            )
          : Icon(
              Icons.flutter_dash,
              size: 140,
            ),
    );
  }

  _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Divider(
        height: 8,
        thickness: 2,
        indent: 10,
        endIndent: 250,
      ),
    );
  }
}

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 70);
  }

  bool shouldReclip(oldClipper) {
    return true;
  }
}
