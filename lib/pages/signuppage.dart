import 'package:chatmate/pages/emailverification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/accountpagebanner.dart';
import '../widgets/custombutton.dart';
import '../widgets/customtxtfeild.dart';
import '../widgets/txtbutton.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? sm;
  final _signupformkey = GlobalKey<FormState>();
  String _emailadress = "";
  String _password = "";
  String _passwordc = "";
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  _submitsignupForm(BuildContext ctx) async {
    try {
      isLoading = true;

      await _auth.createUserWithEmailAndPassword(
          email: _emailadress, password: _password);

    } on FirebaseAuthException catch (err) {
      var msg = "An error occured,check your credentials";

      msg = err.message!;

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  void _trySignUp() async {
    final formst = _signupformkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (formst) {
      _signupformkey.currentState!.save();
      await _submitsignupForm(context);
      if (context.mounted) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const EmailVerification();
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _signupformkey,
        child: SingleChildScrollView(
          child: Column(children: [
            const CustomBanner(
              title: 'Register',
              subtitle: "Create a new account",
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFeild(
              onSave: (value) {
                _emailadress = value!;
              },
              label: "Email Address",
              isobs: false,
              validator: (value) {
                value = value!.toLowerCase();
                if (value.isEmpty || !value.contains("@")) {
                  return " Entered email is invalid";
                }
                return null;
              },
            ),
            CustomTextFeild(
                onSave: (value) {
                  _password = value!;
                },
                label: "Passsword",
                isobs: true,
                validator: (value) {
                  sm = value;
                  if (value!.isEmpty || value.length < 8) {
                    return "Should be minimum of 8 characters";
                  }
                  return null;
                }),
            CustomTextFeild(
                onSave: (value) {
                  _passwordc = value!;
                },
                label: "Confirm passsword",
                isobs: true,
                validator: (value) {
                  if (value!.isEmpty || value != sm) {
                    return "Passwords doesent Match";
                  }
                  return null;
                }),
            isLoading
                ? const CircularProgressIndicator()
                : CustomButton(label: "Create Account", ontap: _trySignUp),
            CustomTextButton(
                text: "Already have an account login",
                ontap: () {
                  Navigator.of(context).pop();
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            )
          ]),
        ),
      ),
    );
  }
}
