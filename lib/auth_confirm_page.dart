import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:zeweter_app/components/input_fields.dart'; // Import the InputBox component

class AuthConfirmPage extends StatefulWidget {
  const AuthConfirmPage({Key? key}) : super(key: key);

  @override
  State<AuthConfirmPage> createState() => _AuthConfirmPageState();
}

class _AuthConfirmPageState extends State<AuthConfirmPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _authenticateAndDelete() async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      // Reauthenticate user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If reauthentication is successful, delete the user account
      await userCredential.user!.delete();
      // Navigate to login page
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to authenticate. Please try again.';
      });
      print('Failed to authenticate or delete account: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputBox(
              HintTxt: 'Email',
              controller: _emailController,
            ),
            SizedBox(height: 16),
            InputBox(
              HintTxt: 'Password',
              controller: _passwordController,
              obscureText: true,
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: _authenticateAndDelete,
                child: Text(
                  'Confirm and Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
