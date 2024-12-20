// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeweter_app/Searchpage.dart';
import 'package:zeweter_app/auth_confirm_page.dart';
import 'package:zeweter_app/favpages/favpage.dart';
import 'package:zeweter_app/firebase_options.dart';
import 'package:zeweter_app/homepage/HomePage.dart';
import 'package:zeweter_app/landing.dart';
import 'package:zeweter_app/login-signup/login.dart';
import 'package:zeweter_app/login-signup/signup.dart';
import 'package:zeweter_app/components/logo.dart';
import 'package:zeweter_app/profilepage/ProfilePage.dart';
import 'package:zeweter_app/services/Firebase_notify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase_api().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const Logo()),
      GoRoute(path: '/login', builder: (context, state) => const Login()),
      GoRoute(path: '/landing', builder: (context, state) => const Landing()),
      GoRoute(path: '/signup', builder: (context, state) => const SignUp()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/search',
        builder: (context, state) {
          final episodes = state.extra as List<Map<String, String>>;
          return SearchPage(episodes: episodes);
        },
      ),
      GoRoute(path: '/favorites', builder: (context, state) => const FavPage()),
      GoRoute(
          path: '/AuthConfirmPage',
          builder: (context, state) => const AuthConfirmPage()),
      GoRoute(
          path: '/profile', builder: (context, state) => const ProfilePage()),
    ],
  );
}
