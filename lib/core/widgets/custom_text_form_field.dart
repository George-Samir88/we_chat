import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.initialValue,
      required this.maxLines,
      required this.hintText,
      required this.labelText,
      required this.prefixIcon,
      this.validator,
      this.onSaved});

  final String? initialValue;
  final int maxLines;
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
          fillColor: Colors.transparent,
          filled: true,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.blue,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.blue,
          )),
    );
  }
}
