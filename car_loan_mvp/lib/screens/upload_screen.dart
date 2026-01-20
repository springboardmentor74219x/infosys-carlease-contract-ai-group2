import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final Color themeColor = const Color(0xFF1A237E);

  File? selectedFile;
  double progress = 0;
  bool uploaded = false;
  bool showResult = false;

  // Pick from storage
  Future pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        uploaded = false;
        showResult = false;
      });
    }
  }

  // Pick from camera
  Future pickFromCamera() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        selectedFile = File(picked.path);
        uploaded = false;
        showResult = false;
      });
    }
  }

  // Upload simulation (replace with real backend)
  Future uploadFile() async {
    if (selectedFile == null) return;

    setState(() => progress = 0);

    // Fake progress animation
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() => progress = i / 10);
    }

    setState(() => uploaded = true);

    await Future.delayed(const Duration(seconds: 1));
    setState(() => showResult = true);
  }

  @override
  Widget build(BuildContext context) {
    if (showResult) return resultScreen();
    if (uploaded) return successScreen();
    return uploadUI();
  }

  // ================= UPLOAD UI =================
  Widget uploadUI() {
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
                  onPressed: pickFromCamera,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Capture from Camera"),
                ),

                const SizedBox(height: 20),

                if (progress > 0 && progress < 1)
                  LinearProgressIndicator(value: progress),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: selectedFile == null ? null : uploadFile,
                    child: const Text("Upload & Analyze"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= SUCCESS SCREEN =================
  Widget successScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 120),
            const SizedBox(height: 20),
            const Text(
              "Upload Successful!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => showResult = true),
              child: const Text("View AI Result"),
            ),
          ],
        ),
      ),
    );
  }