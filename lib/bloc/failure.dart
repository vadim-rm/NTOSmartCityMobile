// ignore_for_file: constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';

enum ErrorCode {
  USER_NOT_FOUND,
  LOGIN_WITH_EMAIL,
  USER_ALREADY_EXISTS,
  PASSWORD_INCORRECT,
  INTERNAL,
  USER_NOT_LOGGED,
}

class Failure {
  final ErrorCode code;
  String? message;

  Failure(this.code);

  @override
  String toString() {
    switch (code) {
      case ErrorCode.USER_NOT_FOUND:
        return "Такого пользователя нет. Пожалуйста, зарегистрируйтесь";
      case ErrorCode.LOGIN_WITH_EMAIL:
        return "Вход через Google недоступен для этого аккаунта";
      case ErrorCode.USER_ALREADY_EXISTS:
        return "Такой пользователь уже зарегистрирован, можно входить";
      case ErrorCode.PASSWORD_INCORRECT:
        return "Неверный пароль";
      case ErrorCode.USER_NOT_LOGGED:
        return "Войдите в аккаунт повторно";
      case ErrorCode.INTERNAL:
        return "Произошла внутренняя ошибка:\n$message";
    }
  }

  factory Failure.fromFirebaseError(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        return Failure(ErrorCode.USER_NOT_FOUND);
      case "email-already-in-use":
        return Failure(ErrorCode.USER_ALREADY_EXISTS);
      case "account-exists-with-different-credential":
        return Failure(ErrorCode.LOGIN_WITH_EMAIL);
      case "wrong-password":
        return Failure(ErrorCode.PASSWORD_INCORRECT);
      default:
        return Failure(ErrorCode.INTERNAL);
    }
  }
}
