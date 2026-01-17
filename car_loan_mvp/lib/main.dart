import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const CarLoanApp());
}

class CarLoanApp extends StatelessWidget {
  const CarLoanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
