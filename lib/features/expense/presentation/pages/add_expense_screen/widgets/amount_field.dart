import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class AmountField extends StatelessWidget {
  final TextEditingController controller;
  const AmountField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  CustomTextFormField(labelText:"Amount",controller: controller,);
  }
}