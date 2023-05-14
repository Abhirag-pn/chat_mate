part of 'resetpassword_bloc.dart';

@immutable
abstract class ResetpasswordEvent {}

class SentResetLinkEvent extends ResetpasswordEvent {
  final String email;

  SentResetLinkEvent(this.email);
}

