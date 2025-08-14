import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('InvestAi channels deposits into a smart crypto strategy. Yields shown are illustrative and accrue daily at 3% on total portfolio value.'),
      ),
    );
  }
}
