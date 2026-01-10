import 'package:flutter/material.dart';

class NegotiationScreen extends StatelessWidget {
  const NegotiationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Negotiation Advice'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Recommended Negotiation Tips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text('• Try negotiating the interest rate'),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text('• Request reduced processing fees'),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text('• Compare offers from other banks'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
