import 'dart:ui';
import 'package:flutter/material.dart';

class NegotiationScreen extends StatefulWidget {
  final String fileName;

  const NegotiationScreen({
    super.key,
    required this.fileName,
  });

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}


class _NegotiationScreenState extends State<NegotiationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slide;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    slide = Tween(begin: const Offset(0, .3), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOutExpo));
    controller.forward();
    super.initState();
  }

  // 🔥 AI Negotiation Logic (demo-ready)
  Map<String, dynamic> getNegotiationData() {
    final name = widget.fileName.toLowerCase();

    if (name.contains("high")) {
      return {
        "apr": "14.8%",
        "tenure": "72 mo",
        "risk": "High",
        "cards": [
          {
            "title": "High Interest Risk",
            "desc": "APR significantly exceeds market average",
            "icon": Icons.trending_up,
            "color": Colors.redAccent
          },
          {
            "title": "Negotiation Tip",
            "desc": "Ask for a reduced interest rate or shorter tenure",
            "icon": Icons.handshake,
            "color": Colors.orangeAccent
          },
          {
            "title": "Penalty Clause",
            "desc": "Early closure penalties detected",
            "icon": Icons.warning,
            "color": Colors.redAccent
          },
        ]
      };
    } else if (name.contains("lease")) {
      return {
        "apr": "11.2%",
        "tenure": "48 mo",
        "risk": "Medium",
        "cards": [
          {
            "title": "Moderate APR",
            "desc": "APR slightly above recommended range",
            "icon": Icons.trending_flat,
            "color": Colors.orangeAccent
          },
          {
            "title": "Negotiation Tip",
            "desc": "Request reduced processing and documentation fees",
            "icon": Icons.handshake,
            "color": Colors.cyanAccent
          },
          {
            "title": "Safe Tenure",
            "desc": "Lease duration is within acceptable limits",
            "icon": Icons.verified,
            "color": Colors.greenAccent
          },
        ]
      };
    } else {
      return {
        "apr": "9.1%",
        "tenure": "36 mo",
        "risk": "Low",
        "cards": [
          {
            "title": "Low Risk Contract",
            "desc": "APR is competitive with market standards",
            "icon": Icons.verified,
            "color": Colors.greenAccent
          },
          {
            "title": "Negotiation Tip",
            "desc": "Try negotiating add-on benefits or cashback",
            "icon": Icons.handshake,
            "color": Colors.cyanAccent
          },
          {
            "title": "Safe Clause",
            "desc": "No risky penalties detected",
            "icon": Icons.security,
            "color": Colors.greenAccent
          },
        ]
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = getNegotiationData();

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
                    const Text(
                      "AI Contract Intelligence",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Chip(
                      label: const Text(
                        "AI Negotiation Ready",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.cyanAccent,
                      avatar: const Icon(Icons.auto_awesome),
                    )
                  ],
                ),
              ),

              const LinearProgressIndicator(
                value: .95,
                color: Colors.cyanAccent,
                backgroundColor: Colors.white12,
              ),

              const SizedBox(height: 20),

              Expanded(
                child: SlideTransition(
                  position: slide,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [

                      for (var card in data["cards"])
                        _glassCard(
                          card["title"],
                          card["desc"],
                          card["icon"],
                          card["color"],
                        ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          _miniTile("APR", data["apr"], Icons.percent),
                          _miniTile("Tenure", data["tenure"], Icons.schedule),
                          _miniTile("Risk", data["risk"], Icons.warning),
                        ],
                      ),

                      const SizedBox(height: 30),

                      Center(
                        child: Tooltip(
                          message: "Return to dashboard",
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.arrow_back),
                            label: const Text("Back to Dashboard"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
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
            boxShadow: [
              BoxShadow(color: color.withOpacity(.4), blurRadius: 20)
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
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
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
