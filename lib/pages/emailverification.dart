import 'dart:async';
import 'package:chatmate/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
    static const routeName="email-verification";
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}
class _EmailVerificationState extends State<EmailVerification> {
  bool isVerified = false;
  Timer? timer;
  checkverified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isVerified) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          
          const SnackBar(
            content: Text("Email Verified Succesfully"),
          ),
        );
        Navigator.of(context)
            .pushReplacementNamed(Homepage.routeName);
      }
      timer?.cancel();
    }
  }

  @override
  void initState() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkverified();
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
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    );
  }
}
