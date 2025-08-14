import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: ctrl, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            FilledButton(onPressed: ()=> Navigator.pop(context, ctrl.text.trim()), child: const Text('Continue'))
          ],
        ),
      ),
    );
  }
}
