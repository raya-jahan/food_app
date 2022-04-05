import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  late final TextEditingController controller;
  late final String labText;
  late final TextInputType keyboardType;
  CustomTextField(this.controller, this.keyboardType, this.labText);
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labText,
      ),
    );
  }
}
