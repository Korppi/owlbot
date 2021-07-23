import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlbot/models/word.dart';
import 'package:owlbot/pages/homepage/homepage_model.dart';
import 'package:owlbot/pages/homepage/homepage_state.dart';
import 'package:owlbot/pages/homepage/widgets/search_row.dart';
import 'package:owlbot/pages/homepage/widgets/word_tab_balls.dart';
import 'package:owlbot/pages/homepage/widgets/word_tabs.dart';
import 'package:owlbot/services/owlbot.dart';
import 'package:owlbot/utils/secrets.dart';

// homepagemodel and homepagestate as statenotifier
final homepageStateNotifierProvider =
    StateNotifierProvider<HomepageModel, HomepageState>(
  (ref) => HomepageModel(
    OwlBot(Secrets.getToken()!), // in main.dart there is null check for token.
  ),
);

/// Only page in the app.
class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('homepage build');
    final state = useProvider(homepageStateNotifierProvider);

    const double padding = 10; // for loading states circular thing...
    return Scaffold(
      appBar: AppBar(
        title: Text('Owlbot'),
      ),
      body: Column(
        children: [
          SearchRow(),
          state.when(
            noError: (Word word) => _buildTabs(word),
            loading: () => Padding(
              padding: const EdgeInsets.only(top: padding),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (String error) => Center(
              child: Text(
                '$error',
                style: TextStyle(color: Colors.red),
              ),
            ),
            init: () => Container(), // nothing here
          ),
        ],
      ),
    );
  }

  _buildTabs(Word word) {
    final pageController = usePageController();
    final tabController = useTabController(
        initialLength: word.definitions.length,
        vsync: useSingleTickerProvider());
    List<Widget> widgets = [];
    widgets.add(WordTabBalls(word, pageController, tabController));
    widgets.add(WordTabs(word, tabController));
    return Expanded(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: widgets,
        ),
      ),
    );
  }
}
