// ignore_for_file: constant_identifier_names

enum ErrorCode {
  USER_NOT_FOUND,
  LOGIN_WITH_EMAIL,
  USER_ALREADY_EXISTS,
  PASSWORD_INCORRECT,
  USER_NOT_LOGGED,
  INVALID_EMAIL,
  USER_NOT_CREATED,
  INTERNAL,
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
      case ErrorCode.INVALID_EMAIL:
        return "Такого Email не существует";
      default:
        return "Произошла внутренняя ошибка";
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
      case "invalid-email":
        return Failure(ErrorCode.INVALID_EMAIL);
      default:
        return Failure(ErrorCode.INTERNAL);
    }
  }
}
