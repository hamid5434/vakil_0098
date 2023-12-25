part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthInitialEvent extends AuthEvent {
  const AuthInitialEvent();
}

class AuthIsSave extends AuthEvent {
  const AuthIsSave();
}

class AuthButtonIsClicked extends AuthEvent {
  final String username;
  final String password;

  const AuthButtonIsClicked({
    required this.username,
    required this.password,
  });
}
