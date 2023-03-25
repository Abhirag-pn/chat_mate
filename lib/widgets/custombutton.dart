import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback ontap;
  const CustomButton({super.key, required this.label, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 15,
          child: ElevatedButton(
              onPressed: ontap,
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ))),
    );
  }
}
