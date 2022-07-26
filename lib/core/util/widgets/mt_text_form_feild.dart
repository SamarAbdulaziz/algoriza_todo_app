import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
   MyTextFormField({
    Key? key,
    required this.hintText,
    this.type,
    this.suffixIcon,
    this.controller,
    required this.onTap,
    required this.validator,
    this.readOnly = false,
  }) : super(key: key);
  final String hintText;
  final TextInputType? type;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function onTap;
  final FormFieldValidator<String>? validator;
  bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: readOnly,
      onTap: () => onTap(),
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.red,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
