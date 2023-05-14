import 'dart:async';

import 'package:chatmate/ui/widgets/custombutton.dart';
import 'package:chatmate/utils/validators.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/resetpassword_bloc/resetpassword_bloc.dart';
import '../widgets/customtxtfeild.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = "forgot-passwords";
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late Timer? timer;
  final TextEditingController _emailcontroller = TextEditingController();
  final forgetformkey = GlobalKey<FormState>();
  int countdown = 0;

  @override
  void dispose() {
    _emailcontroller.dispose();
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetpasswordBloc(),
      child: BlocListener<ResetpasswordBloc, ResetpasswordState>(
        listener: (context, state) {
          if (state is ResetLinkSentState) {
            countdown = 30;
            timer = Timer.periodic(const Duration(seconds: 1), (timer) {
              if (countdown > 0) {
                setState(() {
                  countdown--;
                });
              }
            });
          }
          if (state is ResendReadyState) {
            countdown = 30;
            timer!.cancel();
          }
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errmsg),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
          }
        },
        child: Scaffold(
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: forgetformkey,
                child: CustomTextFeild(
                    controller: _emailcontroller,
                    label: "Email adress",
                    isobs: false,
                    validator: emailValidator),
              ),
              BlocBuilder<ResetpasswordBloc, ResetpasswordState>(
                builder: (context, state) {
                  // if (state is LoadingState) {
                  //   return const CircularProgressIndicator();
                  // } else if (state is ResetLinkSentState) {
                  //   return Padding(
                  //     padding: const EdgeInsets.only(top: 20.0),
                  //     child: Text(
                  //       "You have to wait $countdown seconds to resend link",
                  //       style: Theme.of(context).textTheme.labelLarge,
                  //     ),
                  //   );
                  // } else if (state is ResendReadyState) {
                  //   return CustomButton(
                  //       label: "Resend Link",
                  //       ontap: () {
                  //         if (forgetformkey.currentState!.validate()) {
                  //           BlocProvider.of<ResetpasswordBloc>(context)
                  //               .add(SentResetLinkEvent(_emailcontroller.text));
                  //         }
                  //       });
                  // } else {
                  return CustomButton(
                      label: state is LoadingState
                          ? "Senting..."
                          : state is ResetLinkSentState
                              ? "Wait $countdown seconds"
                              : state is ResendReadyState
                                  ? "Resend Link"
                                  : "Sent Reset Link",
                      ontap: state is ResetLinkSentState?null:() {
                        if (forgetformkey.currentState!.validate()) {
                          BlocProvider.of<ResetpasswordBloc>(context)
                              .add(SentResetLinkEvent(_emailcontroller.text));
                        }
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
