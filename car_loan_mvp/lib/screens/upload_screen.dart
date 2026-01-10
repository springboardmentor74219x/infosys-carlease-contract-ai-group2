import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dashboard_screen.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  Future<void> _pickPdf(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DashboardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Contract')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.upload_file, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text('Upload Car Loan Contract'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _pickPdf(context),
              child: const Text('Upload PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
