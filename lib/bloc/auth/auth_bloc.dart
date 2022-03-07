import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/auth/auth_cubit.dart';
import 'package:nagib_pay/bloc/auth/auth_event.dart';
import 'package:nagib_pay/bloc/auth/auth_state.dart';
import 'package:nagib_pay/bloc/auth/form_mode.dart';
import 'package:nagib_pay/bloc/failure.dart';
import 'package:nagib_pay/bloc/from_sbmission_status.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/repository/auth_repository.dart';
import 'package:nagib_pay/repository/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthCubit authCubit;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  AuthBloc({
    required this.authCubit,
    required this.authRepository,
    required this.userRepository,
  }) : super(AuthState()) {
    // Email updated
    on<AuthEmailChanged>(
      (event, emit) => emit(
        state.copyWith(
          email: event.email,
          formStatus: const InitialFormStatus(),
        ),
      ),
    );

    // Password updated
    on<AuthPasswordChanged>(
      (event, emit) => emit(
        state.copyWith(
          password: event.password,
          formStatus: const InitialFormStatus(),
        ),
      ),
    );

    // From Mode Changed
    on<FormModeChanged>(
      (event, emit) => emit(
        state.copyWith(
          formMode: (state.formMode is SignInMode)
              ? const SignUpMode()
              : const SignInMode(),
          formStatus: state.formStatus is FormSubmitting
              ? null
              : const InitialFormStatus(),
        ),
      ),
    );

    // Obscure password
    on<ObscurePasswordStateChanged>(
      (event, emit) => emit(
        state.copyWith(
          passwordObscured: !state.passwordObscured,
          formStatus: state.formStatus is FormSubmitting
              ? null
              : const InitialFormStatus(),
        ),
      ),
    );

    // Form submitted
    on<FormSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        if (state.formMode is SignInMode) {
          await authRepository.signInWithEmail(
              email: state.email, password: state.password);
        } else {
          await authRepository.signUpWithEmail(
              email: state.email, password: state.password);
        }
        emit(state.copyWith(formStatus: SubmissionSuccess()));
        User user;
        try {
          user = await userRepository.getCurrentUser();
        } on Failure catch (e) {
          print(e.code.toString());
          if (e.code == ErrorCode.USER_NOT_LOGGED) {
            user = User(balance: 0, name: "", surname: "");
          } else {
            rethrow;
          }
        }
        authCubit.launchSession(user);
      } on Failure catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    });
  }
}
