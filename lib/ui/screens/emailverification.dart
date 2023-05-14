import 'dart:async';
import 'package:chatmate/ui/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/email_verify_bloc/email_verification_bloc.dart';

class EmailVerification extends StatefulWidget {
  static const routeName = "email-verification";
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {



  Timer? timer;

@override
  void initState() {
BlocProvider.of<EmailVerificationBloc>(context).add(SentVerifyEmailEvent());
timer=Timer.periodic(Duration(seconds:3), (timer) { 
  BlocProvider.of<EmailVerificationBloc>(context).add(CheckEmailVerifyEvent());
});
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailVerificationBloc, EmailVerificationState>(
      listener: (context, state) {
       if (state is EmailVerifiedState) {
          Navigator.of(context).pushNamed(Homepage.routeName);
        }
      },
      child: Scaffold(
        body: Center(
          child:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Verifying email",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ]),
        ),
      ),
    );
  }
}
