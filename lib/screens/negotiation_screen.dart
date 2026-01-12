import 'dart:ui';
import 'package:flutter/material.dart';

class NegotiationScreen extends StatefulWidget {
  const NegotiationScreen({super.key});

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slide;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    slide = Tween(begin: const Offset(0, .3), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOutExpo));
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF050B24), Color(0xFF0A0F3C), Color(0xFF120458)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [

              // HERO HEADER
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("AI Contract Intelligence",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 8),
                    Chip(
                      label: const Text("AI Processing", style: TextStyle(color: Color.fromARGB(255, 1, 0, 0))),
                      backgroundColor: Colors.cyanAccent.withOpacity(.2),
                      avatar: const Icon(Icons.auto_awesome, color: Colors.cyanAccent),
                    )
                  ],
                ),
              ),

              // STEPPER BAR
              const LinearProgressIndicator(value: .85, color: Colors.cyanAccent, backgroundColor: Colors.white12),

              const SizedBox(height: 20),

              Expanded(
                child: SlideTransition(
                  position: slide,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [

                      _glassCard("Interest Risk", "APR is higher than market average", Icons.trending_up, Colors.redAccent),
                      _glassCard("Negotiation Tip", "Request reduced processing fees", Icons.handshake, Colors.cyanAccent),
                      _glassCard("Safe Clause", "Tenure length is within safe range", Icons.verified, Colors.greenAccent),

                      const SizedBox(height: 20),

                      // MINI ANALYTICS
                      Row(
                        children: [
                          _miniTile("APR", "11.4%", Icons.percent),
                          _miniTile("Tenure", "60 mo", Icons.schedule),
                          _miniTile("Risk", "Medium", Icons.warning),
                        ],
                      ),

                      const SizedBox(height: 30),

                      Center(
                        child: Tooltip(
                          message: "Return to dashboard",
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.arrow_back),
                            label: const Text("Go Back"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 12,
                              shadowColor: Colors.cyanAccent,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassCard(String title, String desc, IconData icon, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.07),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: color.withOpacity(.4), blurRadius: 20)],
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(desc, style: const TextStyle(color: Colors.white70)),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniTile(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        color: Colors.white.withOpacity(.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: Colors.cyanAccent),
              const SizedBox(height: 6),
              Text(title, style: const TextStyle(color: Colors.white70)),
              Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
