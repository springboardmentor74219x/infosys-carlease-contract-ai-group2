import 'dart:ui';
import 'package:flutter/material.dart';
import 'upload_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    scale = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF050716), Color(0xFF0B0F2E), Color(0xFF3A0CA3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: scale,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  width: 380,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.06),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(color: Color(0xFF4CC9F0), blurRadius: 28),
                      BoxShadow(color: Color(0xFF7209B7), blurRadius: 48),
                    ],
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.auto_awesome, color: Color(0xFF4CC9F0), size: 72),
                    const SizedBox(height: 10),
                    const Text("AI Contract Vault",
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 30),
                    _field("Username", Icons.person),
                    const SizedBox(height: 16),
                    _field("Password", Icons.lock, obscure: true),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.login),
                        label: const Text("Access AI Workspace"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7209B7),
                          foregroundColor: Colors.white,
                          shadowColor: const Color(0xFF4CC9F0),
                          elevation: 18,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () => Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => const UploadScreen())),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(String hint, IconData icon, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF4CC9F0)),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white.withOpacity(.08),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
      ),
    );
  }
}
