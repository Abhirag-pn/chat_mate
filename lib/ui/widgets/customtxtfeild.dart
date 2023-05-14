import 'package:chatmate/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFeild extends StatefulWidget {
  final String label;
  final bool isobs;
  final String? deafult;
  final TextEditingController controller;

  final String? Function(String?)? validator;

  final bool readonly;
  const CustomTextFeild(
      {super.key,
      required this.label,
      required this.isobs,
      this.validator,
      this.deafult,
      this.readonly = false,
      required this.controller});

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  bool hide = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          TextFormField(
              readOnly: widget.readonly,
              initialValue: widget.deafult,
              controller: widget.controller,
              validator: widget.validator,
              style: Theme.of(context).textTheme.bodySmall,
              cursorColor: Theme.of(context).colorScheme.secondary,
              obscureText: hide,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: widget.isobs
                    ? IconButton(
                        onPressed: () {
                          hide = !hide;
                          setState(() {});
                        },
                        icon: Icon(
                          hide ? Icons.visibility : Icons.visibility_off,
                          color: primary,
                        ))
                    : null,
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error, width: 1.0),
                    borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error, width: 1.0),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: primary, width: 2.0),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: primary, width: 1.0),
                    borderRadius: BorderRadius.circular(10)),
              )),
        ],
      ),
    );
  }
}
