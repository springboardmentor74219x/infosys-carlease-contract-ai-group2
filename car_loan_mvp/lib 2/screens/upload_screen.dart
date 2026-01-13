import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dashboard_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isAnalyzing = false;

  @override
  void initState() {
    super.initState();
    // Subtle floating animation for the icon
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickPdf(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return;

    setState(() => _isAnalyzing = true);

    // Simulate AI analysis "delight" factor
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const DashboardScreen(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth > 600 ? 500 : screenWidth * 0.9;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF), // Matching the Light Blue theme
      body: Stack(
        children: [
          // Background blobs for depth
          Positioned(
              top: -100,
              left: -100,
              child: _buildBlob(300, Colors.blue.withOpacity(0.1))),

          Center(
            child: SingleChildScrollView(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: cardWidth,
                padding: const EdgeInsets.all(24),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(color: Colors.blue.shade100, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 30),
                    child: _isAnalyzing
                        ? _buildLoadingState()
                        : _buildUploadState(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadState(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Animated Icon
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 10 * _controller.value),
              child: child,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.cloud_upload_outlined,
                size: 64, color: Colors.blue.shade600),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Upload Contract',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A237E)),
        ),
        const SizedBox(height: 12),
        Text(
          'Drop your car loan PDF here to let our AI\nidentify savings opportunities.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blueGrey.shade400, fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 40),

        // Dotted Border Area (Visual "Drop Zone")
        InkWell(
          onTap: () => _pickPdf(context),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue.shade50.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: Colors.blue.shade200,
                  style: BorderStyle.solid,
                  width:
                      1), // Standard border as Flutter doesn't native dash easily without painter
            ),
            child: Column(
              children: [
                Icon(Icons.picture_as_pdf_rounded, color: Colors.blue.shade300),
                const SizedBox(height: 8),
                Text('Tap to browse files',
                    style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w600)),
                const Text('Maximum file size: 10MB',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(
              strokeWidth: 6, strokeCap: StrokeCap.round),
        ),
        const SizedBox(height: 32),
        const Text(
          'Analyzing Contract...',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          'Our AI is scanning interest rates, fees,\nand hidden clauses.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blueGrey.shade400),
        ),
      ],
    );
  }

  Widget _buildBlob(double size, Color color) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}
