import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'email_verification_event.dart';
part 'email_verification_state.dart';

class EmailVerificationBloc
    extends Bloc<EmailVerificationEvent, EmailVerificationState> {
  EmailVerificationBloc() : super(EmailNotVerifiedState()) {
    on<SentVerifyEmailEvent>((event, emit) async {
      try {
        await FirebaseAuth.instance.currentUser!.reload();
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      } on FirebaseAuthException catch (err) {
        String? message;
        if (err.code.isNotEmpty) {
          message = err.code.toString();
        } else {
          message = "Unexpected error occured";
        }
        emit(ErrorVerificationState(message));
      }
    });
    on<CheckEmailVerifyEvent>((event, emit) async {
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        emit(EmailVerifiedState());
      } else {
        emit(EmailNotVerifiedState());
      }
    });
  }
}
