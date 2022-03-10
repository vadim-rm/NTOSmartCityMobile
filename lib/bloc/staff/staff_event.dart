import 'package:nagib_pay/types/trash_types.dart';
import 'package:nagib_pay/types/sensors_types.dart';

abstract class StaffEvent {}

class ConnectBluetooth extends StaffEvent {}

class CheckServo extends StaffEvent {}

class ChangedCheckbox extends StaffEvent {
  final SensorType sensorType;
  final TrashType trashType;

  ChangedCheckbox({
    required this.sensorType,
    required this.trashType,
  });
}

class FormSubmitted extends StaffEvent {}
