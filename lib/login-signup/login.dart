import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:zeweter_app/components/input_fields.dart';
import 'package:zeweter_app/loading.dart';
import 'package:zeweter_app/services/firestore.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // If login is successful, retrieve the user's additional data from Firestore
      final userData =
          await _firestoreService.getUser(userCredential.user!.uid);
      final username = userData['username'];

      // Navigate to landing page or any other page
      GoRouter.of(context).go('/landing');
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to sign in: $e'; // Display error message
      });
      print('Failed to sign in: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            InputBox(
              HintTxt: 'Email',
              controller: emailController,
            ),
            SizedBox(height: 16), // Space between fields
            InputBox(
              HintTxt: 'Password',
              controller: passwordController,
              obscureText: true, // Mask the password input
            ),
            SizedBox(
                height: 20), // Space between fields and loading/error widget
            LoadingWithError(
              isLoading: _isLoading,
              errorText: _errorMessage,
            ),
            SizedBox(
                height: 20), // Space between loading/error widget and button
            ElevatedButton(
              onPressed: signIn,
              child: const Text('Login'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).go('/signup');
                  },
                  child: const Text('Signup'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
