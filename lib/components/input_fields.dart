import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    required this.description,
    required this.controller,
  });

  final String description;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 13),
          child: Text(
            description,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        TextField(
          controller: controller, // Use the controller passed from the parent
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
