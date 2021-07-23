import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:owlbot/models/word.dart';

part 'homepage_state.freezed.dart';

@freezed
class HomepageState with _$HomepageState {
  const factory HomepageState.noError(Word word) = _NoError;
  const factory HomepageState.loading() = _Loading;
  const factory HomepageState.error(String message) = _Error;
  const factory HomepageState.init() = _Init;
}
