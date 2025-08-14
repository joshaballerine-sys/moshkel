import 'package:flutter/material.dart';
import 'src/screens/home.dart';

void main() {
  runApp(const InvestAiApp());
}

class InvestAiApp extends StatelessWidget {
  const InvestAiApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InvestAi',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00ADB5))),
      home: const HomeScreen(),
    );
  }
}
