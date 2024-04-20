import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeweter_app/components/input_fields.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
              description: 'Email',
              controller: emailController,
            ),
            InputBox(
              description: 'Password',
              controller: passwordController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  // Use email and password as needed
                  GoRouter.of(context).go('/landing');
                },
                child: const Text('Login'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    String email = emailController.text;
                    String password = passwordController.text;
                    GoRouter.of(context).go('/signup');
                  },
                  child: const Text('Signup'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
