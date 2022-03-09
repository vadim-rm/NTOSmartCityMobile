import 'package:nagib_pay/models/container.dart';

class ContainersState {
  final List<TrashContainer>? containers;
  final bool loaded;

  ContainersState({
    this.containers,
    this.loaded = false,
  });

  ContainersState copyWith({
    List<TrashContainer>? containers,
    bool? loaded,
  }) {
    return ContainersState(
      containers: containers ?? this.containers,
      loaded: loaded ?? this.loaded,
    );
  }
}
