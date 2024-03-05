import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/assets/logo/logo.png',
        width: 80,
        height: 80,
      ),
    );
  }
}
