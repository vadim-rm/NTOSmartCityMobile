import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/models/container.dart';
import 'package:nagib_pay/models/trash_report.dart';

class ContainersState {
  final List<TrashContainer>? containers;
  final bool loaded;
  final FormSubmissionStatus formStatus;
  final bool blocked;
  final List<TrashReport> reports;

  ContainersState({
    this.containers,
    this.loaded = false,
    this.formStatus = const InitialFormStatus(),
    this.blocked = false,
    this.reports = const [],
  });

  ContainersState copyWith({
    List<TrashContainer>? containers,
    bool? loaded,
    FormSubmissionStatus? formStatus,
    bool? blocked,
    List<TrashReport>? reports,
  }) {
    return ContainersState(
      containers: containers ?? this.containers,
      loaded: loaded ?? this.loaded,
      formStatus: formStatus ?? this.formStatus,
      blocked: blocked ?? this.blocked,
      reports: reports ?? this.reports,
    );
  }
}
