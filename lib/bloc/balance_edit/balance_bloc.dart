import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/balance_edit/balance_event.dart';
import 'package:nagib_pay/bloc/balance_edit/balance_state.dart';
import 'package:nagib_pay/bloc/failure.dart';
import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/repository/admin_repository.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final User user;
  final AdminRepository adminRepository;

  BalanceBloc({
    required this.user,
    required this.adminRepository,
  }) : super(BalanceState(balance: user.balance)) {
    on<BalanceChanged>(
      (event, emit) => emit(
        state.copyWith(
          balance: event.balance,
        ),
      ),
    );

    on<FormSubmitted>(
      (event, emit) async {
        emit(
          state.copyWith(
            formStatus: FormSubmitting(),
          ),
        );

        try {
          if (user.balance != state.balance) {
            await adminRepository.changeBalance(
            user: user,
            balance: state.balance,
          );
          }

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
