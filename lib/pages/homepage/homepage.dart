import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlbot/models/word.dart';
import 'package:owlbot/pages/homepage/homepage_model.dart';
import 'package:owlbot/pages/homepage/homepage_state.dart';
import 'package:owlbot/pages/homepage/widgets/search_row.dart';
import 'package:owlbot/services/owlbot.dart';
import 'package:owlbot/utils/secrets.dart';

final homepageStateNotifierProvider =
    StateNotifierProvider<HomepageModel, HomepageState>(
  (ref) => HomepageModel(
    // TODO: check this later, should only be getToken() without '?? ""' stuff
    OwlBot(Secrets.getToken() ?? ''),
  ),
);

// change back to class HomePage extends StatelessWidget later on
// also check hooks version of consumerwidget
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    debugPrint('homepage build');
    final state = watch(homepageStateNotifierProvider);
    return state.when(
        noError: (Word word) => Text('no error'),
        loading: () => Text('loading!'),
        error: (errorr) => Text(errorr!), // see the ! this is for testing now
        init: () => buildScaffold());
  }

  buildScaffold() {
    debugPrint('scaffold build at homepage init state build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Owlbot'),
      ),
      body: ListView(
        children: [
          SearchRow(),
        ],
      ),
    );
  }
}
