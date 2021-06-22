import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlbot/models/word.dart';
import 'package:owlbot/pages/homepage/homepage_state.dart';
import 'package:owlbot/services/owlbot.dart';

class HomepageModel extends StateNotifier<HomepageState> {
  final OwlBot _owlBot;

  HomepageModel(this._owlBot) : super(const HomepageState.init());

  Future<void> define(String? searchWord) async {
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
