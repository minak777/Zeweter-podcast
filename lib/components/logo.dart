import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeweter_app/login-signup/login.dart';

class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      GoRouter.of(context).go('/login');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'lib/assets/logo/logo2.png',
          // width: 80,
          //height: 80,
        ),
      ),
    );
  }
}
