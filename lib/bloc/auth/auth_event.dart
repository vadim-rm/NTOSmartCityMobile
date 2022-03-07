abstract class AuthEvent {}

class AuthEmailChanged extends AuthEvent {
  final String email;

  AuthEmailChanged({required this.email});
}

class AuthPasswordChanged extends AuthEvent {
  final String password;

  AuthPasswordChanged({required this.password});
}

class ObscurePasswordStateChanged extends AuthEvent {}

class FormModeChanged extends AuthEvent {}

class FormSubmitted extends AuthEvent {}
