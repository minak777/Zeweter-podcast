import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeweter_app/login-signup/input_fields.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller =
      TextEditingController(); // Define and initialize nameController here

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
          InputBox(description: 'User name', controller: nameController),
          InputBox(description: 'Email', controller: emailcontroller),
          InputBox(description: 'Password', controller: passwordcontroller),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () {
                // Use email and password as needed
                GoRouter.of(context).go('/landing');
              },
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
