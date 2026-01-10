import 'package:flutter/material.dart';
import 'screens/upload_screen.dart';

void main() {
  runApp(const CarLoanApp());
}

class CarLoanApp extends StatelessWidget {
  const CarLoanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UploadScreen(),
    );
  }
}
