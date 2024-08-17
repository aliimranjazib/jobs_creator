import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  String? labelText = "";
  InputField({
    super.key,
    this.labelText,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        labelText: "$labelText",
      ),
    );
  }
}
