part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginRequestEvent extends AuthEvent{
  final String email,password;

  LoginRequestEvent({required this.email, required this.password});
}

class SignUpRequestEvent extends AuthEvent {
  final String email,password;

  SignUpRequestEvent({required this.email, required  this.password});
}


class SignUpToggleEvent extends AuthEvent {}

class LoginToggleEvent extends AuthEvent {}


