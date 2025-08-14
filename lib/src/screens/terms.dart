import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Deposits remain locked for 30 days. Early withdrawals return principal without yield. Rewards and yields are displayed only and non-withdrawable.'),
      ),
    );
  }
}
