import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nagib_pay/bloc/failure.dart';
import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/bloc/staff/staff_event.dart';
import 'package:nagib_pay/bloc/staff/staff_state.dart';
import 'package:nagib_pay/repository/staff_repository.dart';
import 'package:nagib_pay/types/sensors_types.dart';
import 'package:nagib_pay/types/trash_types.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final StaffRepository staffRepository;

  StaffBloc({
    required this.staffRepository,
  }) : super(StaffState()) {
    on<ConnectBluetooth>(
      (event, emit) async {
        bool isConnected = await staffRepository.connectBluetooth();
        print("IS CONNECTED" + isConnected.toString());
        emit(state.copyWith(
          isConnected: isConnected,
        ));
        // List<User?> users = await staffRepository.getUsers();
        //
        // emit(
        //   state.copyWith(
        //     allUsers: users,
        //     filteredUsers: users,
        //     loaded: true,
        //   ),
        // );
      },
    );

    on<CheckServo>(
      (event, emit) async {
        await staffRepository.checkServo();
      },
    );

    on<ChangedCheckbox>(
      (event, emit) {
        Map<SensorType, Map<TrashType, bool>> newSensorsStatus = {
          ...state.sensorsStatus
        };
        newSensorsStatus[event.sensorType] =
            Map.of(state.sensorsStatus[event.sensorType]!);

        newSensorsStatus[event.sensorType]![event.trashType] =
            !newSensorsStatus[event.sensorType]![event.trashType]!;
        emit(state.copyWith(
          sensorsStatus: newSensorsStatus,
        ));
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
          await staffRepository.sendReport(state.sensorsStatus);
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
