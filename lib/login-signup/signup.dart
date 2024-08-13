import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:zeweter_app/components/input_fields.dart';
import 'package:zeweter_app/loading.dart';
import 'package:zeweter_app/services/firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final username = nameController.text.trim();

      // Check if the username, email, and password fields are not empty
      if (email.isEmpty || password.isEmpty || username.isEmpty) {
        throw Exception('Please fill in all fields.');
      }

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add the user data to Firestore
      await firestoreService.addUser({
        'userId': userCredential.user!.uid,
        'username': username,
        'profilePicUrl': '', // Default to empty string if not uploaded
      });

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Show a dialog or snackbar to inform the user to check their email
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Verify Your Email'),
          content: Text(
              'A verification email has been sent to ${userCredential.user!.email}. Please check your email and verify your account before logging in.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                GoRouter.of(context).go('/login');
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print('Failed to sign up: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              InputBox(
                HintTxt: 'User name',
                controller: nameController,
              ),
              SizedBox(height: 16), // Space between fields
              InputBox(
                HintTxt: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
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
                onPressed: signUp,
                child: const Text('Sign up'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Have an account? "),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).go('/login');
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
