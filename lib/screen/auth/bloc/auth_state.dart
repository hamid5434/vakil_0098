part of 'auth_bloc.dart';

abstract class AuthState {
  final bool isSave;
  const AuthState(this.isSave);

}

class AuthInitial extends AuthState {
  const AuthInitial(bool isSave) : super(isSave);

}

class AuthLoading extends AuthState {
  const AuthLoading(bool isSave) : super(isSave);
}

class AuthSuccess extends AuthState {
  const AuthSuccess(bool isSave) : super(isSave);
}

class AuthFailed extends AuthState {
  final AppException exception;

  const AuthFailed({required bool isSave, required this.exception}): super(isSave);
}