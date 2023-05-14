part of 'email_verification_bloc.dart';

@immutable
abstract class EmailVerificationState {}

class EmailNotVerifiedState extends EmailVerificationState {}

class CheckingVerficationState extends EmailVerificationState {}

class ErrorVerificationState extends EmailVerificationState {
  final String errmsg;

  ErrorVerificationState(this.errmsg);
}

class EmailVerifiedState extends EmailVerificationState {}
