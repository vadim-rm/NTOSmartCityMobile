import 'package:flutter_blue/flutter_blue.dart';
import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/types/sensors_types.dart';
import 'package:nagib_pay/types/trash_types.dart';

class StaffState {
  final bool isConnected;
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final FormSubmissionStatus formStatus;

  final Map<SensorType, Map<TrashType, bool>> sensorsStatus;

  StaffState({
    this.isConnected = false,
    this.sensorsStatus = const {
      SensorType.servo: {
        TrashType.glass: false,
        TrashType.paper: false,
        TrashType.plastic: false,
      },
      SensorType.color: {
        TrashType.glass: false,
        TrashType.paper: false,
        TrashType.plastic: false,
      },
      SensorType.distance: {
        TrashType.glass: false,
        TrashType.paper: false,
        TrashType.plastic: false,
      },
    },
    this.formStatus = const InitialFormStatus(),
  });

  StaffState copyWith({
    bool? isConnected,
    Map<SensorType, Map<TrashType, bool>>? sensorsStatus,
    FormSubmissionStatus? formStatus,
  }) {
    return StaffState(
      isConnected: isConnected ?? this.isConnected,
      sensorsStatus: sensorsStatus ?? this.sensorsStatus,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
