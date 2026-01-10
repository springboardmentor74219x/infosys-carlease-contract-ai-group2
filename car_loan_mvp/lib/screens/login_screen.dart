import 'package:flutter/material.dart';
import 'upload_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: ElevatedButton(
          child: Text("Continue"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => UploadScreen()),
            );
          },
        ),
      ),
    );
  }
}