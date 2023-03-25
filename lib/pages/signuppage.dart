
import 'package:flutter/material.dart';
import '../widgets/accountpagebanner.dart';
import '../widgets/custombutton.dart';
import '../widgets/customtxtfeild.dart';
import '../widgets/txtbutton.dart';

class SignUpPage extends StatefulWidget {


 
  const  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
     String? sm;
     final _signupformkey=GlobalKey<FormState>();
     String? _emailadress="";
     String? _password="";
     String? otp="";
     String? _passwordc="";

      
     void _trySignUp(){
      final formst=_signupformkey.currentState!.validate();
              FocusScope.of(context).unfocus();
      if(formst){
        _signupformkey.currentState!.save();

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
            onSave: (value){
              _emailadress=value;

            },
              label: "Email Address",
              isobs: false,
               validator:  (value){
                if(value!.isEmpty||!value.contains("@"))
                {
                  return " Entered email is invalid";
                }
                return null;
              },
              
            ),
             CustomTextFeild(
              onSave: (value){
                otp=value;
              },
              label: "OTP",
              isobs: false,
              sub: true,
               validator:  (value){
                if(value!.isEmpty){
                  return "Field should not be empty";
                }
                return null;
              }
            ),
            CustomTextFeild(
              onSave: (value){
                _password=value;
              },
              label: "Passsword",
              isobs: true,
               validator:  (value){
                 sm=value;
                if(value!.isEmpty||value.length<8){
                  return "Should be minimum of 8 characters";
                }
                return null;
              }
            ),
             CustomTextFeild(
              onSave: (value){
                _passwordc=value;
              },
              label: "Confirm passsword",
              isobs: true,
              validator:  (value){
               
                if(value!.isEmpty||value!=sm){
                  return "Passwords doesent Match";
                }
                return null;
              }
            ),
             CustomButton(label: "Create Account",ontap:_trySignUp),
            CustomTextButton(
                text: "Already have an account login",
                ontap: () {
                  Navigator.of(context)
                      .pop();
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
