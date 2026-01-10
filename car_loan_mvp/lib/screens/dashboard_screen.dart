import 'package:flutter/material.dart';
import 'negotiation_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Loan Assistant'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Contract Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Customer: Arjun Patel'),
                    Text('Vehicle: SUV'),
                    Text('EMI: ₹27,500'),
                    Text('Interest: 10.8%'),
                    Text('Tenure: 72 months'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NegotiationScreen(),
                  ),
                );
              },
              child: const Text('View Negotiation Advice'),
            ),
          ],
        ),
      ),
    );
  }
}
