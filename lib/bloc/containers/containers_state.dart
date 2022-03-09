import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/models/container.dart';

class ContainersState {
  final List<TrashContainer>? containers;
  final bool loaded;
  final FormSubmissionStatus formStatus;
  final bool blocked;

  ContainersState({
    this.containers,
    this.loaded = false,
    this.formStatus = const InitialFormStatus(),
    this.blocked = false,
  });

  ContainersState copyWith({
    List<TrashContainer>? containers,
    bool? loaded,
    FormSubmissionStatus? formStatus,
    bool? blocked,
  }) {
    return ContainersState(
      containers: containers ?? this.containers,
      loaded: loaded ?? this.loaded,
      formStatus: formStatus ?? this.formStatus,
      blocked: blocked ?? this.blocked,
    );
  }
}
