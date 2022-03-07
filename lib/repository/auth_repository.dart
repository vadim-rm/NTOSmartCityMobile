import 'package:firebase_auth/firebase_auth.dart';
import 'package:nagib_pay/bloc/failure.dart';

class AuthRepository {
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Failure.fromFirebaseError(e.code);
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Failure.fromFirebaseError(e.code);
    }
    return;
  }
}
