import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    required this.HintTxt,
    required this.controller,
    this.obscureText = false, // Default to false for non-password fields
    this.keyboardType = TextInputType.text, // Default to text keyboard type
  });

  final String HintTxt;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(width: 1),
            ),
            hintText: HintTxt,
          ),
        ),
      ],
    );
  }
}
