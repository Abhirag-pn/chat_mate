import 'package:chatmate/pages/signuppage.dart';
import 'package:chatmate/widgets/accountpagebanner.dart';
import 'package:chatmate/widgets/customtxtfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../widgets/custombutton.dart';
import '../widgets/txtbutton.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AcoountPageState();
}

class _AcoountPageState extends State<AccountPage> {
  final _loginformkey=GlobalKey<FormState>();
  String _emailadress="";
  String _password="";

  void _submitForm(){


  }

  void _tryLogin(){
    final isValid=_loginformkey.currentState!.validate();
      FocusScope.of(context).unfocus();
    if(isValid){
      _loginformkey.currentState!.save();

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
              onSave: (value){
                _emailadress=value!;
              },
              validator: (value){
                if(value!.isEmpty||!value.contains("@")){
                  return " Entered email is invalid";
                }
                return null;
              },
              label: "Email Address",
              isobs: false,
              sub: false,
            ),
            CustomTextFeild(
              onSave: (value){
                _password=value!;
              },
              label: "Passsword",
              isobs: true,
              sub: false,
             validator:  (value){
                if(value!.isEmpty||value.length<8){
                  return "Should be minimum of 8 characters";
                }
                return null;
              }
            ),
            CustomButton(label: "Login",ontap: _tryLogin),
              SizedBox(
            height: MediaQuery.of(context).size.height *0.02,
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextButton(
                    text: "Sign Up",
                    ontap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const SignUpPage();
                      }));
                    }),
                CustomTextButton(text: "Forgot Passsword?",ontap: (){},)
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
