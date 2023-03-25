import 'package:chatmate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFeild extends StatefulWidget {
  final String label;
  final bool isobs;
  final bool sub;
  final String? Function(String?)? validator;
  final void Function(String?)? onSave;
  const CustomTextFeild({super.key, required this.label, required this.isobs,this.sub=false, required this.validator, required this.onSave} );

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  bool hide=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 20,vertical:8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          TextFormField(
            onSaved: widget.onSave,
            validator:widget.validator ,
            inputFormatters: [LowerCaseFormat()],
              style: Theme.of(context).textTheme.bodySmall,
              cursorColor: Theme.of(context).colorScheme.secondary,
   obscureText: hide,
              textCapitalization: TextCapitalization.none,
              decoration:  InputDecoration(
                isDense: true,
suffixIcon:widget.isobs?IconButton(onPressed: (){hide=!hide;
setState(() {
  
});
}, icon: Icon(hide?Icons.visibility:Icons.visibility_off,color:primary,)):null,
             errorBorder:  OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2.0),
                  borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: primary, width: 3.0),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:const  BorderSide(color: primary, width: 2.0),
                   borderRadius: BorderRadius.circular(10)
                ),
              )),
             if(widget.sub)
             Text(
            "*an otp will be sent to above email please enter it",
            style: Theme.of(context).textTheme.displaySmall,
          ) 
        ],
      ),
    );
  }
}

class LowerCaseFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toLowerCase(),
    selection: newValue.selection);
  }
}
