import 'package:chatmate/pages/forgotpassword.dart';
import 'package:chatmate/pages/signuppage.dart';
import 'package:chatmate/widgets/accountpagebanner.dart';
import 'package:chatmate/widgets/customtxtfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../widgets/custombutton.dart';
import '../widgets/txtbutton.dart';

class AccountPage extends StatefulWidget {
  static const routeName = "signin";
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AcoountPageState();
}

class _AcoountPageState extends State<AccountPage> {
  final _loginformkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _emailadress = "";
  String _password = "";

  _submitloginForm(BuildContext ctx) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailadress, password: _password);
    } on FirebaseAuthException catch (err) {
      var message = "An error occured,check your credentials";

      message = err.code;

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
  }

  void _tryLogin() async {
    final isValid = _loginformkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _loginformkey.currentState!.save();
      await _submitloginForm(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginformkey,
        child: SingleChildScrollView(
          child: Column(children: [
            const CustomBanner(
              title: 'Welcome',
              subtitle: "Login to continue",
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFeild(
              onSave: (value) {
                _emailadress = value!;
              },
              validator: (value) {
                value = value!.toLowerCase();
                if (value.isEmpty || !value.contains("@")) {
                  return " Entered email is invalid";
                }
                return null;
              },
              label: "Email Address",
              isobs: false,
            ),
            CustomTextFeild(
                onSave: (value) {
                  _password = value!;
                },
                label: "Passsword",
                isobs: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return "Should be minimum of 8 characters";
                  }
                  return null;
                }),
            CustomButton(label: "Login", ontap: _tryLogin),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextButton(
                    text: "Sign Up",
                    ontap: () {
                      Navigator.of(context).pushNamed(SignUpPage.routeName);
                    }),
                CustomTextButton(
                  text: "Forgot Passsword?",
                  ontap: () {
                    Navigator.of(context).pushNamed(ForgotPassword.routeName);
                  },
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            )
          ]),
        ),
      ),
    );
  }
}
