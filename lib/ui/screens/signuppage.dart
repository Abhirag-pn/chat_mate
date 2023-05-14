import 'dart:developer';

import 'package:chatmate/ui/screens/emailverification.dart';
import 'package:chatmate/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/email_verify_bloc/email_verification_bloc.dart';
import '../widgets/accountpagebanner.dart';
import '../widgets/custombutton.dart';
import '../widgets/customtxtfeild.dart';
import '../widgets/txtbutton.dart';
import 'homepage.dart';
import 'loginpage.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = "signup";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _cpasswordcontroller = TextEditingController();
  final _signupformkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _cpasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginState) {
            Navigator.pushNamed(context, AccountPage.routeName);
          } else if (state is SuccesfullySignedState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider(
                create: (context) => EmailVerificationBloc(),
                child: EmailVerification(),
              );
            }));
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.error,
                content: Text(state.errmsg),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      controller: _emailcontroller,
                      label: "Email Address",
                      isobs: false,
                      validator: emailValidator),
                  CustomTextFeild(
                    controller: _passwordcontroller,
                    label: "Passsword",
                    isobs: true,
                    validator: passwordValidator,
                  ),
                  CustomTextFeild(
                      controller: _cpasswordcontroller,
                      label: "Confirm passsword",
                      isobs: true,
                      validator: (value) {
                        if (value!.isEmpty ||
                            _cpasswordcontroller.text !=
                                _passwordcontroller.text.trim()) {
                          return "Passwords doesent Match";
                        }
                        return null;
                      }),
                  CustomButton(
                      label: "Create Account",
                      ontap: () {
                        log(_emailcontroller.text);

                        if (_signupformkey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            SignUpRequestEvent(
                              email: _emailcontroller.text,
                              password: _passwordcontroller.text,
                            ),
                          );
                        }
                      }),
                  CustomTextButton(
                      text: "I already have an account - login",
                      ontap: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(LoginToggleEvent());
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
