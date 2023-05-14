part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class LoginState extends AuthState {}

class SignUpState extends AuthState {}

class LoadingState extends AuthState {}

class ErrorState extends AuthState {
  final String errmsg;

  ErrorState(this.errmsg);
}

class SuccesfullyLoggedState extends AuthState {}

class SuccesfullySignedState extends AuthState {}

