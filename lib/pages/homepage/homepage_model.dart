import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlbot/models/word.dart';
import 'package:owlbot/pages/homepage/homepage_state.dart';
import 'package:owlbot/services/owlbot.dart';

/// Model for homepage and model for most stuff in app.
class HomepageModel extends StateNotifier<HomepageState> {
  final OwlBot _owlBot; // owlbot wrapper

  HomepageModel(this._owlBot) : super(const HomepageState.init());

  /// Defines word
  Future<void> define(String? searchWord) async {
    if (searchWord == null || searchWord.isEmpty) {
      state = HomepageState.init();
    } else {
      state = HomepageState.loading();
      Word? word = await _owlBot.define(searchWord);
      if (word == null) {
        state = HomepageState.error('No word found.');
      } else {
        state = HomepageState.noError(word);
      }
    }
  }
}
