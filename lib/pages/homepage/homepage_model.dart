import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlbot/models/word.dart';
import 'package:owlbot/pages/homepage/homepage_state.dart';
import 'package:owlbot/services/owlbot.dart';

/// Model for homepage and model for most stuff in app.
class HomepageModel extends StateNotifier<HomepageState> {
  final OwlBot _owlBot; // owlbot wrapper

  HomepageModel(this._owlBot) : super(const HomepageState.init());

  // TODO: delete this function
  /// test function, to be deleted later
  Future<void> testFunction() async {
    // testing state changes!
    debugPrint('hello :)');
    await Future.delayed(Duration(seconds: 5));
    state = HomepageState.loading();
    await Future.delayed(Duration(seconds: 5));
    state = HomepageState.error('got any errors?');
    await Future.delayed(Duration(seconds: 5));
    state = HomepageState.init();
  }

  /// Defines word.
  ///
  /// Does not actually return anything but changes states
  Future<void> define(String? searchWord) async {
    // TODO: remove Future.delayed stuff from here at some point...
    debugPrint('lets search word $searchWord');
    await Future.delayed(Duration(seconds: 5));
    if (searchWord == null || searchWord.isEmpty) {
      debugPrint('null or empty, so state will be init');
      state = HomepageState.init();
    } else {
      debugPrint('not empty and not null, so state will be loading');
      state = HomepageState.loading();
      await Future.delayed(Duration(seconds: 5));
      debugPrint('lets call api');
      Word? word = await _owlBot.define(searchWord);
      if (word == null) {
        debugPrint('api call return null, so state will be error');
        state = HomepageState.error('No word found.');
      } else {
        debugPrint('api call return word, so state will be noError');
        state = HomepageState.noError(word);
      }
    }
    debugPrint('search ended');
  }
}
