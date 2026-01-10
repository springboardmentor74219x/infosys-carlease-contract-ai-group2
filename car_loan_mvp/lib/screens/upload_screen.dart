import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dashboard_screen.dart';
class UploadScreen extends StatefulWidget {
const UploadScreen({super.key});
@override
State<UploadScreen> createState() => _UploadScreenState();
}
class _UploadScreenState extends State<UploadScreen> {
bool loading = false;
String? selectedFileName;
Future<void> pickAndUploadFile() async {
try {
setState(() => loading = true);
final result = await FilePicker.platform.pickFiles(
type: FileType.custom,
allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
withData: true,
);
if (result == null) {
setState(() => loading = false);
return;
}
final Uint8List fileBytes = result.files.single.bytes!;
final String fileName = result.files.single.name;
setState(() => selectedFileName = fileName);
await ApiService.uploadContractBytes(fileBytes, fileName);
if (mounted) {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => const DashboardScreen()),
);
}
} catch (e) {
setState(() => loading = false);
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text("Upload failed: $e")),
);
}
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text("Upload Contract")),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,

children: [
ElevatedButton(
onPressed: loading ? null : pickAndUploadFile,
child: loading
? const CircularProgressIndicator()
: const Text("Select PDF / Image"),
),
const SizedBox(height: 10),
if (selectedFileName != null)
Text("Selected: $selectedFileName"),
],
),
),
);
}
}