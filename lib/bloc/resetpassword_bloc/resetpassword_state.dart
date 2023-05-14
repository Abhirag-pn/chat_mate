part of 'resetpassword_bloc.dart';

@immutable
abstract class ResetpasswordState {}

class ResetpasswordInitial extends ResetpasswordState {}

class ResetLinkSentState extends ResetpasswordState {}

class LoadingState extends ResetpasswordState {}

class ErrorState extends ResetpasswordState {
  final String errmsg;

  ErrorState(this.errmsg);
}

class ResendReadyState extends ResetpasswordState {}
