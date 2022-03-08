import 'package:nagib_pay/models/user.dart';

class UsersState {
  final List<User?> users;
  final bool loaded;
  UsersState({
    this.users = const [],
    this.loaded = false,
  });

  UsersState copyWith({
    List<User?>? users,
    bool? loaded,
  }) {
    return UsersState(
      users: users ?? this.users,
      loaded: loaded ?? this.loaded,
    );
  }
}
