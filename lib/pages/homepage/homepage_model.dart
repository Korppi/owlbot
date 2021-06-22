import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlbot/pages/homepage/homepage_state.dart';

class HomepageModel extends StateNotifier<HomepageState> {
  HomepageModel() : super(const HomepageState.init());
}
