

import 'package:chatmate/widgets/custombutton.dart';
import 'package:chatmate/widgets/customtxtfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ForgotPassword extends StatefulWidget {
    static const routeName="forgot-passwords";
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgetformkey=GlobalKey<FormState>();
  String email="test";
  _sentEmail(BuildContext ctx) async {
    
    try {
      final isValid = forgetformkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      forgetformkey.currentState!.save();
    
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            content: Text("Password reset link sent to $email"),),);
      }}
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(err.code)));
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Reset Password",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Form(
            key: forgetformkey,
            child: CustomTextFeild(
                label: "Email adress",
                isobs: false,
                validator: (value) {
                  value = value!.toLowerCase();
                  if (value.isEmpty || !value.contains("@")) {
                    return " Entered email is invalid";
                  }
                  return null;
                },
                onSave: (value) {
                email=value!;
                }),
          ),
          CustomButton(
              label: "Sent Reset Link",
              ontap: () {
                _sentEmail(context);
              }),
        ],
      ),
    );
  }
}
