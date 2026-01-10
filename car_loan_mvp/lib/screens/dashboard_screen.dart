import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            const Text(
              "Contract uploaded successfully",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              "Next step: OCR, Risk Analysis & Negotiation",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            //  NEGOTIATION BUTTON
            ElevatedButton(
              child: const Text("Get Negotiation Advice"),
              onPressed: () async {
                final reply = await ApiService.getNegotiationAdvice(
                  "How can I reduce my APR?",
                );

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Negotiation Assistant"),
                    content: Text(reply),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
