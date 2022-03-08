import 'package:bloc/bloc.dart';
import 'package:nagib_pay/bloc/session/session_cubit.dart';
import 'package:nagib_pay/models/user.dart';

enum AuthNavigationState { auth }

class AuthCubit extends Cubit<AuthNavigationState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthNavigationState.auth);

  void showAuth() => emit(AuthNavigationState.auth);

  void launchSession(User user) {
    sessionCubit.showSession();
    sessionCubit.setUser(user: user);
  }
}
