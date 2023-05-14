import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LoginState()) {
    on<LoginRequestEvent>(
      (event, emit) async {
        emit(LoadingState());
        try {
         UserCredential? user= await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(
            SuccesfullyLoggedState(),
          );
        } on FirebaseException catch (err) {
          String? message;
          if (err.code.isNotEmpty) {
            message = err.code;
          } else {
            message = "An error occured,check your credentials";
          }
          emit(
            ErrorState(message),
          );

        }
      },
    );

    on<SignUpRequestEvent>((event, emit) async {
      emit(LoadingState());
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(
          SuccesfullySignedState(),
        );
      } on FirebaseAuthException catch (err) {
        String? message;
        if (err.code.isNotEmpty) {
          message = err.message;
        } else {
          message = "An error occured,check your credentials";
        }
        emit(
          ErrorState(message!),
        );

        message = err.code;
      }
    });

    on<SignUpToggleEvent>((event, emit) {
      emit (SignUpState());
    });

    on<LoginToggleEvent>((event, emit) {
      emit(LoginState());
    });
  }
}
