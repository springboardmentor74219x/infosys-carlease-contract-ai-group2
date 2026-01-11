import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void getAdvice(BuildContext context) async {
    String response =
        await ApiService.negotiate("How can I negotiate my car loan?");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Negotiation Advice"),
        content: Text(response),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => getAdvice(context),
          child: const Text("Get Negotiation Advice"),
        ),
      ),
    );
  }
}
