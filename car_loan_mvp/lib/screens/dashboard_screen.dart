import 'dart:ui';
import 'package:flutter/material.dart';
import 'negotiation_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<Offset> slide;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    slide = Tween(begin: const Offset(0, .4), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOutQuart));
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050716),
      appBar: AppBar(
        title: const Text("AI Control Center"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SlideTransition(
        position: slide,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              // STATUS TILE
              _glassStatus(
                icon: Icons.auto_awesome,
                title: "AI Processing Complete",
                subtitle: "OCR, Risk & Compliance Engine ✔",
                badge: "SAFE",
                badgeColor: Colors.greenAccent,
              ),

              const SizedBox(height: 18),

              // ANALYTICS
              Row(
                children: [
                  _miniTile("Risk Level", "Low", Icons.security, Colors.greenAccent),
                  _miniTile("APR", "9.75%", Icons.trending_down, Colors.cyanAccent),
                ],
              ),

              const SizedBox(height: 28),

              // CTA
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.cyanAccent, Colors.deepPurpleAccent],
                  ),
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: const [
                    BoxShadow(color: Colors.cyanAccent, blurRadius: 25)
                  ],
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                  ),
                  icon: const Icon(Icons.psychology),
                  label: const Text("Launch Negotiation AI"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NegotiationScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassStatus({required IconData icon, required String title, required String subtitle, required String badge, required Color badgeColor}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.07),
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [BoxShadow(color: Colors.blueAccent, blurRadius: 20)],
          ),
          child: Row(
            children: [
              Icon(icon, size: 42, color: Colors.cyanAccent),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
                  Text(subtitle, style: const TextStyle(color: Colors.white54)),
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(badge, style: TextStyle(color: badgeColor)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniTile(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.06),
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12)],
        ),
        child: Column(children: [
          Icon(icon, color: color),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(title, style: const TextStyle(color: Colors.white54, fontSize: 11))
        ]),
      ),
    );
  }
}
