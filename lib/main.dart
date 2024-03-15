// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeweter_app/landing.dart';
import 'package:zeweter_app/login-signup/login.dart';
import 'package:zeweter_app/login-signup/signup.dart';
import 'package:zeweter_app/logo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // home: Landing(),
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const Logo()),
    GoRoute(path: '/login', builder: (context, state) => const Login()),
    GoRoute(path: '/landing', builder: (context, state) => const Landing()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUp()),
  ]);
}
