import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'negotiation_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? selectedFile;
  double progress = 0.0;
  bool isUploading = false;

  // Pick any file
  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedFile = File(result.files.single.path!);
          progress = 0;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("File selected successfully")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("File error: $e")));
    }
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (picked != null) {
        setState(() {
          selectedFile = File(picked.path);
          progress = 0;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image selected successfully")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Image error: $e")));
    }
  }

  // Upload simulation
  Future<void> uploadFile() async {
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a file first")),
      );
      return;
    }

    setState(() {
      isUploading = true;
      progress = 0.01;
    });

    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      setState(() {
        progress = i / 10;
      });
    }

    setState(() => isUploading = false);

    // Navigate after upload
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const NegotiationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
          ),
        ),
        child: Center(
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_upload, size: 80),
                const SizedBox(height: 10),
                const Text(
                  "Upload Contract",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                if (selectedFile != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.insert_drive_file),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            selectedFile!.path.split('/').last,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: pickFile,
                  icon: const Icon(Icons.folder),
                  label: const Text("Select File"),
                ),

                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed: pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text("Select Image"),
                ),

                const SizedBox(height: 20),

                if (progress > 0) LinearProgressIndicator(value: progress),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isUploading ? null : uploadFile,
                    child: Text(
                      isUploading ? "Uploading..." : "Upload & Analyze",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
