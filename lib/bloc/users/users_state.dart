import 'package:nagib_pay/models/user.dart';

class UsersState {
  final List<User?> allUsers;
  final List<User?> filteredUsers;
  final bool loaded;
  UsersState({
    this.allUsers = const [],
    this.filteredUsers = const [],
    this.loaded = false,
  });

  UsersState copyWith({
    List<User?>? allUsers,
    List<User?>? filteredUsers,
    bool? loaded,
  }) {
    return UsersState(
      allUsers: allUsers ?? this.allUsers,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      loaded: loaded ?? this.loaded,
    );
  }
}
