import 'package:chatmate/constants/colors.dart';
import 'package:flutter/material.dart';

class BioTextFeild extends StatefulWidget {
  final String label;
  

  final String? Function(String?)? validator;
  final void Function(String?)? onSave;
  const BioTextFeild(
      {super.key,
      required this.label,
      required this.validator,
      required this.onSave});

  @override
  State<BioTextFeild> createState() => _BioTextFeildState();
}

class _BioTextFeildState extends State<BioTextFeild> {
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
            maxLines: null,
              onSaved: widget.onSave,
              validator: widget.validator,
              style: Theme.of(context).textTheme.bodySmall,
              cursorColor: Theme.of(context).colorScheme.secondary,
              obscureText: hide,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                isDense: true,
               
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
