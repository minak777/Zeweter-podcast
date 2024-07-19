import 'package:flutter/material.dart';

class LoadingWithError extends StatelessWidget {
  final bool isLoading;
  final String? errorText;

  const LoadingWithError({
    Key? key,
    required this.isLoading,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? CircularProgressIndicator() // Show loading circle
          : errorText != null
              ? Text(
                  errorText!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ) // Show error text if provided
              : SizedBox.shrink(), // Empty widget if no loading and no error
    );
  }
}
