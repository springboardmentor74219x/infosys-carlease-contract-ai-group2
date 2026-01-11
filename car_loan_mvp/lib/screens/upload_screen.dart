import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/api_service.dart';
import 'dashboard_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  Uint8List? fileBytes;
  String? fileName;
  bool isLoading = false;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
      withData: true,
    );

    if (result != null) {
      setState(() {
        fileBytes = result.files.single.bytes;
        fileName = result.files.single.name;
      });
    }
  }

  Future<void> uploadFile() async {
    if (fileBytes == null || fileName == null) return;

    setState(() {
      isLoading = true;
    });

    bool success = await ApiService.uploadContract(fileBytes!, fileName!);

    setState(() {
      isLoading = false;
    });

    if (success && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Upload failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Contract")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickFile,
              child: const Text("Pick Contract (PDF/Image)"),
            ),
            const SizedBox(height: 10),
            Text(fileName ?? "No file selected"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : uploadFile,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
