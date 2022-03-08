import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/failure.dart';
import 'package:nagib_pay/bloc/session/session_state.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/repository/user_repository.dart';

class SessionCubit extends Cubit<SessionState> {
  final UserRepository userRepository;
  User? get currentUser =>
      state is Authenticated ? (state as Authenticated).user : null;

  User? get user =>
      state is Authenticated ? (state as Authenticated).user : null;

  SessionCubit({required this.userRepository}) : super(Unknown()) {
    attemptAutoLogin();
  }

  void showAuth() => emit(Unauthenticated());

  void showSession() => emit(Authenticated());

  void showEditView() =>
      emit((state as Authenticated).copyWith(showEditView: true));

  void popFromEditView() => emit((state as Authenticated).copyWith(
        showEditView: false,
        blockPop: false,
      ));

  Future<void> setUser({required User user}) async {
    if (user.isInfoNeeded && state is Authenticated) {
      emit((state as Authenticated).copyWith(
        blockPop: true,
        showEditView: true,
      ));
    }
    emit((state as Authenticated).copyWith(user: user));
  }

  void signOut({bool endSession = true}) async {
    try {
      await firebase.FirebaseAuth.instance.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  void attemptAutoLogin() async {
    try {
      User user = await userRepository.getCurrentUser();
      emit(Authenticated());
      setUser(user: user);
    } on Failure {
      emit(Unauthenticated());
    }
  }
}
