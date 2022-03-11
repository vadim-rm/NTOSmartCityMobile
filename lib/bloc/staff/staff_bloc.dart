import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nagib_pay/bloc/failure.dart';
import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/bloc/staff/staff_event.dart';
import 'package:nagib_pay/bloc/staff/staff_state.dart';
import 'package:nagib_pay/extensions/bluetooth_constants.dart';
import 'package:nagib_pay/models/trash_report.dart';
import 'package:nagib_pay/repository/staff_repository.dart';
import 'package:nagib_pay/types/sensors_types.dart';
import 'package:nagib_pay/types/trash_types.dart';
import 'package:quick_blue/quick_blue.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final StaffRepository staffRepository;
  final TrashReport? trashReport;
  final bool isEditable;

  StaffBloc({
    required this.staffRepository,
    this.trashReport,
    this.isEditable = false,
  }) : super(
          StaffState(
            trashReport: trashReport ?? const TrashReport(),
            isEditable: isEditable,
          ),
        ) {

    void onConnectionChanged(String deviceId, BlueConnectionState state) {
      print('_handleConnectionChange $deviceId, ${state.value}');
    }
    void onCharacteristicsChange(

        String deviceId, String characteristicId, Uint8List value) {
      print('_handleValueChange $deviceId, $characteristicId, $value');
      print(String.fromCharCodes(value));
      if (characteristicId == characteristicUUID) {
        String data = String.fromCharCodes(value);

        Map<SensorType, Map<TrashType, bool>> newStatus =
            Map.of(state.trashReport.status);

        switch (data) {
          // a(color), 1(dist) - glass
          // b(color), 2(dist) - plastic
          // c(color), 3(dist) - paper
          case "1":
            newStatus[SensorType.distance]![TrashType.glass] = true;
            break;
          case "2":
            newStatus[SensorType.distance]![TrashType.plastic] = true;
            break;
          case "3":
            newStatus[SensorType.distance]![TrashType.paper] = true;
            break;
          case "a":
            newStatus[SensorType.color]![TrashType.glass] = true;
            break;
          case "b":
            newStatus[SensorType.color]![TrashType.glass] = true;
            break;
          case "c":
            newStatus[SensorType.color]![TrashType.glass] = true;
            break;
        }
      }
    }

    on<ConnectBluetooth>(
      (event, emit) async {
        await staffRepository.connectBluetooth(onCharacteristicsChange, onConnectionChanged);
        emit(state.copyWith(
          isConnected: true,
        ));
      },
    );

    on<CheckServo>(
      (event, emit) async {
        await staffRepository.checkServo();
      },
    );

    on<ChangedCheckbox>(
      (event, emit) {
        Map<SensorType, Map<TrashType, bool>> newStatus =
            Map.of(state.trashReport.status);

        newStatus[event.sensorType] = Map.of(newStatus[event.sensorType]!);

        newStatus[event.sensorType]![event.trashType] =
            !newStatus[event.sensorType]![event.trashType]!;

        emit(
          state.copyWith(
            trashReport: state.trashReport.copyWith(
              status: newStatus,
            ),
          ),
        );
      },
    );

    on<FormSubmitted>(
      (event, emit) async {
        try {
          emit(
            state.copyWith(
              formStatus: FormSubmitting(),
            ),
          );
          await staffRepository.sendReport(state.trashReport);
          emit(
            state.copyWith(
              formStatus: SubmissionSuccess(),
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            state.copyWith(
              formStatus: SubmissionFailed(
                Failure.fromFirebaseError(e.code),
              ),
            ),
          );
        }
      },
    );
  }
}
