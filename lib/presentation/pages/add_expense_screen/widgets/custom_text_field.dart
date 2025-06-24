import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final bool readOnly;
  final VoidCallback? onTap;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;


  const CustomTextFormField({
    super.key,
    this.controller,
    required this.labelText,
    this.hintText,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      onTap: onTap,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: InputBorder.none, // Removes underline in normal state
        focusedBorder: InputBorder.none,
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
       // border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}
