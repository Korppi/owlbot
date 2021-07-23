import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:owlbot/models/definition.dart';
import 'package:owlbot/models/word.dart';
import 'package:url_launcher/url_launcher.dart';

class WordTabs extends HookWidget {
  final Word _word;
  final TabController _tabController;

  const WordTabs(this._word, this._tabController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: Container(
          child: TabBarView(
            children: _buildTabs(context),
            controller: _tabController,
          ),
        ),
      ),
    );
  }

  _buildTabs(BuildContext context) {
    List<Widget> defcards = [];
    _word.definitions.forEach((def) {
      defcards.add(_buildDefinitionCardNew(context, def));
    });
    return defcards;
  }

  _buildDefinitionCardNew(BuildContext context, Definition def) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 2,
      child: ListView(
        children: [
          _buildImage(def),
          _buildWordAndPronunciationRow(context, def),
          _buildDivider(),
          _buildExampleRow(context, def),
          _buildDivider(),
          _builDefinitionRow(context, def),
          _buildDivider(),
          _buildEmoji(def),
        ],
      ),
    );
  }

  _buildWordAndPronunciationRow(BuildContext context, Definition def) {
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
                        child: Icon(
                          Icons.text_fields,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Word',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
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
                        child: Icon(
                          Icons.record_voice_over,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Pronunciation',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
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

  _buildExampleRow(BuildContext context, Definition def) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.format_quote,
                color: Colors.green,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Example',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Container(
              width: 250,
              child: Text(def.example ?? ''),
            ),
          ],
        ),
      ],
    );
  }

  _builDefinitionRow(BuildContext context, Definition def) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.description,
                color: Colors.green,
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Definition',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Container(
              width: 250,
              child: Text(
                def.definition,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildEmoji(Definition def) {
    return def.emoji != null
        ? Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  utf8.decode(def.emoji!.runes.toList()),
                  style: TextStyle(fontSize: 48),
                ),
              ],
            ),
          )
        : Container();
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
              color: Colors.green,
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
        color: Colors.green,
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
