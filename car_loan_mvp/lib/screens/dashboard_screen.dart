import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Loan Assistant'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 20),
            const Text(
              'Negotiation Advice',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.orangeAccent,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: const [
                    Text('• Negotiate interest rate'),
                    Text('• Reduce loan tenure'),
                    Text('• Compare other bank offers'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
