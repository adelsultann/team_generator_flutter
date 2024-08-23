import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouletteState {
  final List<String> names;
  final String newResultName;

  RouletteState({
    this.names = const [],
    this.newResultName = '',
  });

  RouletteState copyWith({List<String>? names, String? newResultName}) {
    return RouletteState(
      names: names ?? this.names,
      newResultName: newResultName ?? this.newResultName,
    );
  }
}

class RouletteNotifier extends StateNotifier<RouletteState> {
  RouletteNotifier() : super(RouletteState());

  void setNames(List<String> names) {
    state = state.copyWith(names: names);
  }

  void setResultName(String name) {
    state = state.copyWith(newResultName: name);
    print(name);
  }
}

final rouletteProvider =
    StateNotifierProvider<RouletteNotifier, RouletteState>((ref) {
  return RouletteNotifier();
});
