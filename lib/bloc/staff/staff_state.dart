import 'package:flutter_blue/flutter_blue.dart';
import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/models/trash_report.dart';

class StaffState {
  final bool isConnected;
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final FormSubmissionStatus formStatus;
  final bool isEditable;
  final TrashReport trashReport;

  StaffState({
    this.isConnected = false,
    this.formStatus = const InitialFormStatus(),
    required this.isEditable,
    required this.trashReport,
  });

  StaffState copyWith({
    bool? isConnected,
    TrashReport? trashReport,
    FormSubmissionStatus? formStatus,
    bool? isEditable,
  }) {
    return StaffState(
      isConnected: isConnected ?? this.isConnected,
      trashReport: trashReport ?? this.trashReport,
      formStatus: formStatus ?? this.formStatus,
      isEditable: isEditable ?? this.isEditable,
    );
  }
}
