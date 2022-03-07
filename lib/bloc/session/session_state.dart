import 'package:nagib_pay/models/user.dart';

abstract class SessionState {}

class Unknown extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  User? user;
  bool blockPop;
  bool showEditView;

  Authenticated({
    this.user,
    this.blockPop = false,
    this.showEditView = false,
  });

  Authenticated copyWith({
    User? user,
    bool? blockPop,
    bool? showEditView,
  }) {
    return Authenticated(
      user: user ?? this.user,
      blockPop: blockPop ?? this.blockPop,
      showEditView: showEditView ?? this.showEditView,
    );
  }
}
