import 'package:bloc/bloc.dart';
import 'package:nagib_pay/bloc/failure.dart';
import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/bloc/session/session_cubit.dart';
import 'package:nagib_pay/bloc/session/session_state.dart';
import 'package:nagib_pay/bloc/user_edit/user_edit_event.dart';
import 'package:nagib_pay/bloc/user_edit/user_edit_state.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/repository/user_repository.dart';
import 'package:nagib_pay/extensions/string_extension.dart';

class UserEditBloc extends Bloc<UserEditEvent, UserEditState> {
  final SessionCubit sessionCubit;
  final UserRepository userRepository;

  final bool skipIfFilled;

  UserEditBloc({
    required this.skipIfFilled,
    required this.sessionCubit,
    required this.userRepository,
  }) : super(UserEditState()) {
    on<Init>(
      (event, emit) async {
        User user;
        if (sessionCubit.state is Authenticated &&
            sessionCubit.currentUser != null) {
          user = sessionCubit.currentUser!;
        } else {
          user = await userRepository.getCurrentUser();
        }

        if (!user.isInfoNeeded && skipIfFilled) {
          await sessionCubit.setUser(
              user: await userRepository.getCurrentUser());
        }
        emit(state.copyWith(
          user: user,
          loaded: true,
        ));
      },
    );

    on<NameChanged>(
      (event, emit) => emit(
        state.copyWith(
          user: state.user!.copyWith(
            name: event.name,
          ),
        ),
      ),
    );

    on<SurnameChanged>(
      (event, emit) => emit(
        state.copyWith(
          user: state.user!.copyWith(
            surname: event.surname,
          ),
        ),
      ),
    );

    on<MiddleNameChanged>(
          (event, emit) => emit(
        state.copyWith(
          user: state.user!.copyWith(
            middleName: event.middleName,
          ),
        ),
      ),
    );

    on<AddressChanged>(
          (event, emit) => emit(
        state.copyWith(
          user: state.user!.copyWith(
            address: event.address,
          ),
        ),
      ),
    );

    on<FormSubmitted>(
      (event, emit) async {
        emit(
          state.copyWith(
            formStatus: FormSubmitting(),
            user: state.user!.copyWith(
              name: state.user!.name.capitalize(),
              surname: state.user!.surname.capitalize(),
              middleName: state.user!.middleName.capitalize(),
            ),
          ),
        );
        try {
          await userRepository.updateUser(state.user!);
          await sessionCubit.setUser(user: state.user!);
          emit(state.copyWith(formStatus: SubmissionSuccess()));
          sessionCubit.popFromEditView();
        } on Failure catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(e)));
        }
      },
    );
  }
}
