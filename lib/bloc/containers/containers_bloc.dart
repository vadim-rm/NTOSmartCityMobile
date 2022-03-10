import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/containers/containers_event.dart';
import 'package:nagib_pay/bloc/containers/containers_state.dart';
import 'package:nagib_pay/models/container.dart';
import 'package:nagib_pay/models/trash_report.dart';
import 'package:nagib_pay/repository/admin_repository.dart';

import '../failure.dart';
import '../from_submission_status.dart';

class ContainersBloc extends Bloc<ContainersEvent, ContainersState> {
  final AdminRepository adminRepository;

  ContainersBloc({
    required this.adminRepository,
  }) : super(ContainersState()) {
    on<Init>(
      (event, emit) async {
        List<TrashContainer> containers = await adminRepository.getContainers();
        List<TrashReport> reports = await adminRepository.getReports();
        emit(
          state.copyWith(
            containers: containers,
            loaded: true,
            blocked: containers[0].blocked,
            reports: reports,
          ),
        );
      },
    );

    on<FormSubmitted>(
      (event, emit) async {
        emit(
          state.copyWith(
            formStatus: FormSubmitting(),
          ),
        );

        try {
          await adminRepository.blockStation(!state.blocked);
          emit(
            state.copyWith(
              formStatus: SubmissionSuccess(),
              blocked: !state.blocked,
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
