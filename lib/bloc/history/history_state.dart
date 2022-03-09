import 'package:nagib_pay/models/history_action.dart';

class HistoryState {
  final List<HistoryAction>? history;
  final bool loaded;

  HistoryState({
    this.history,
    this.loaded = false,
  });

  HistoryState copyWith({
    List<HistoryAction>? history,
    bool? loaded,
  }) {
    return HistoryState(
      history: history ?? this.history,
      loaded: loaded ?? this.loaded,
    );
  }
}
