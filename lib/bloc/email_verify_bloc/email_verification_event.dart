part of 'email_verification_bloc.dart';

@immutable
abstract class EmailVerificationEvent {}

class CheckEmailVerifyEvent extends EmailVerificationEvent{}

class SentVerifyEmailEvent extends EmailVerificationEvent{}
