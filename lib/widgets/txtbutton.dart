import 'package:flutter/material.dart';


class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const CustomTextButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: ontap, child: Text(text,style: Theme.of(context).textTheme.labelSmall,) );
  }
}