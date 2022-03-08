import 'package:nagib_pay/bloc/from_submission_status.dart';

import 'form_mode.dart';

class AuthState {
  final String email;

  bool get isValidEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  final String password;

  bool get isValidPassword => password.length >= 8;

  final bool passwordObscured;

  final FormSubmissionStatus formStatus;
  final FormMode formMode;

  AuthState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
    this.formMode = const SignInMode(),
    this.passwordObscured = true,
  });

  AuthState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
    FormMode? formMode,
    bool? passwordObscured,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      formMode: formMode ?? this.formMode,
      passwordObscured: passwordObscured ?? this.passwordObscured,
    );
  }
}
