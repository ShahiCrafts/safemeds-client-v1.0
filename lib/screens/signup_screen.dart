import 'package:flutter/material.dart';
import 'home_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Name'),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Enter name'),
            ),
            const SizedBox(height: 16),
            const Text('Email'),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'Enter email'),
            ),
            const SizedBox(height: 16),
            const Text('Password'),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Enter password'),
            ),
            const SizedBox(height: 16),
            const Text('Confirm Password'),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Confirm password'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
