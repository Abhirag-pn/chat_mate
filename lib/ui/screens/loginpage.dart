import 'package:chatmate/ui/screens/emailverification.dart';
import 'package:chatmate/ui/screens/forgotpassword.dart';
import 'package:chatmate/ui/screens/homepage.dart';
import 'package:chatmate/ui/screens/signuppage.dart';
import 'package:chatmate/ui/widgets/accountpagebanner.dart';
import 'package:chatmate/ui/widgets/customtxtfeild.dart';
import 'package:chatmate/utils/validators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../widgets/custombutton.dart';
import '../widgets/txtbutton.dart';

class AccountPage extends StatefulWidget {
  static const routeName = "signin";
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AcoountPageState();
}

class _AcoountPageState extends State<AccountPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final _loginformkey = GlobalKey<FormState>();

  @override
  void dispose() {
  _emailcontroller.dispose();
  _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignUpState) {
             Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushNamed(context, SignUpPage.routeName);
          } else if (state is SuccesfullyLoggedState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushNamed(context, EmailVerification.routeName);
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
                    controller: _emailcontroller,
                    validator: emailValidator,
                    label: "Email Address",
                    isobs: false,
                  ),
                  CustomTextFeild(
                      controller: _passwordcontroller,
                      label: "Passsword",
                      isobs: true,
                      validator: passwordValidator),
                  state is LoadingState
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          label: "Login",
                          ontap: () {
                            if (_loginformkey.currentState!.validate()) {
                              BlocProvider.of<AuthBloc>(context).add(
                                  LoginRequestEvent(
                                      email: _emailcontroller.text.trim(),
                                      password:
                                          _passwordcontroller.text.trim()));
                            }
                          }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomTextButton(
                          text: "Sign Up",
                          ontap: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(SignUpToggleEvent());
                          }),
                      CustomTextButton(
                        text: "Forgot Passsword?",
                        ontap: () {
                          Navigator.pushNamed(
                              context, ForgotPassword.routeName);
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
        },
      ),
    );
  }
}
