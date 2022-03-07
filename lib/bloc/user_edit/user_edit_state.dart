import 'package:nagib_pay/bloc/from_sbmission_status.dart';
import 'package:nagib_pay/models/user.dart';

class UserEditState {
  final User? user;
  final bool loaded;

  bool get isNameValid =>
      user != null && !RegExp(r"^[А-Яа-я]+$").hasMatch(user!.name);

  bool get isSurnameValid => !RegExp(r"^[А-Яа-я]+$").hasMatch(user!.surname);

  final FormSubmissionStatus formStatus;

  UserEditState({
    this.user,
    this.loaded = false,
    this.formStatus = const InitialFormStatus(),
  });

  UserEditState copyWith({
    User? user,
    bool? loaded,
    FormSubmissionStatus? formStatus,
  }) {
    return UserEditState(
      user: user ?? this.user,
      loaded: loaded ?? this.loaded,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
