import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part 'resetpassword_event.dart';
part 'resetpassword_state.dart';

class ResetpasswordBloc extends Bloc<ResetpasswordEvent, ResetpasswordState> {
  ResetpasswordBloc() : super(ResetpasswordInitial()) {
    on<SentResetLinkEvent>((event, emit) async{
      try {
        emit(LoadingState());
       await  FirebaseAuth.instance.sendPasswordResetEmail(email: event.email);
        emit(ResetLinkSentState());
        await Future.delayed(const Duration(seconds: 30));
         emit(ResendReadyState());

      } on FirebaseException catch (e) {
        String? message;
        if (e.code.isNotEmpty) {
          message = e.code.toString();
        } else {
          message = "Unexpected error occured";
        }
        emit(ErrorState(message));
      }


    });



  }
}
