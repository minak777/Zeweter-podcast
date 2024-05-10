import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeweter_app/components/input_fields.dart';
import 'package:zeweter_app/services/firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signUp() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // If the user is created successfully, add the username to Firestore
      await firestoreService.addUser({
        'userId': userCredential.user!.uid,
        'username': nameController.text,
      });

      // Navigate to landing page or any other page
      GoRouter.of(context).go('/login');
    } catch (e) {
      print('Failed to sign up: $e');
      // Handle sign up errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          InputBox(HintTxt: 'User name', controller: nameController),
          InputBox(HintTxt: 'Email', controller: emailController),
          InputBox(HintTxt: 'Password', controller: passwordController),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: signUp,
              child: const Text(' Sign up  '),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("have an account? "),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).go('/login');
                },
                child: const Text('Login'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
