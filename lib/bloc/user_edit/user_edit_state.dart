import 'dart:io';

import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/models/user.dart';

class UserEditState {
  final User? user;
  final bool loaded;
  final File? avatar;

  bool get isNameNotValid =>
      user != null && user!.name.length < 2;

  bool get isSurnameNotValid => user!.surname.length < 2;

  bool get isMiddleNameNotValid => user!.middleName.length < 2;

  bool get isAddressNotValid => user!.address.length < 2;

  final FormSubmissionStatus formStatus;

  UserEditState({
    this.user,
    this.loaded = false,
    this.formStatus = const InitialFormStatus(),
    this.avatar,
  });

  UserEditState copyWith({
    User? user,
    bool? loaded,
    FormSubmissionStatus? formStatus,
    File? avatar,
  }) {
    return UserEditState(
      user: user ?? this.user,
      loaded: loaded ?? this.loaded,
      formStatus: formStatus ?? this.formStatus,
      avatar: avatar ?? this.avatar,
    );
  }
}
