/// Base class for all client side exceptions
sealed class AppException implements Exception {
  AppException(this.code, this.message);
  final String message;
  final String code;

  @override
  String toString() => message;
}


class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException() : super('email-already-in-use', 'Email already in use');
}

class UserNotFoundException extends AppException {
  UserNotFoundException() : super('user-not-found', 'User not found, check that you entered the right email and password');
}

class IdenticalPasswordException extends AppException {
  IdenticalPasswordException() : super('identical-password', 'New password is the same as the old password');
}

class PasswordTooShortException extends AppException {
  PasswordTooShortException() : super('password-too-short', 'Password is too short');
}


