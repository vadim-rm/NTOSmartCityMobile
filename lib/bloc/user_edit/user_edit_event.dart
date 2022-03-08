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

class MiddleNameChanged extends UserEditEvent {
  final String middleName;

  MiddleNameChanged({required this.middleName});
}

class AddressChanged extends UserEditEvent {
  final String address;

  AddressChanged({required this.address});
}

class FormSubmitted extends UserEditEvent {}
