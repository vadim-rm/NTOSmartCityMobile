abstract class UserEditEvent {}

class Init extends UserEditEvent {}

class NameChanged extends UserEditEvent {
  final String name;

  NameChanged({required this.name});
}

class SurnameChanged extends UserEditEvent {
  final String surname;

  SurnameChanged({required this.surname});
}

class FormSubmitted extends UserEditEvent {}
