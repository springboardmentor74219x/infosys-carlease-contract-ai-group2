import 'package:flutter/material.dart';

class NegotiationScreen extends StatefulWidget {
  const NegotiationScreen({super.key});

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  // Mock data for staggered animation control
  final List<Map<String, dynamic>> _adviceList = [
    {
      'icon': Icons.percent_rounded,
      'title': 'Negotiate Interest Rate',
      'desc':
          'Banks often have a 0.25% - 0.5% buffer. A 0.5% drop saves you roughly ₹45,000 over 5 years.',
      'color': Colors.blue,
    },
    {
      'icon': Icons.receipt_long_rounded,
      'title': 'Waiver on Processing Fees',
      'desc':
          'Ask for a 100% waiver. Documentation fees are almost always negotiable for high-credit profiles.',
      'color': Colors.indigo,
    },
    {
      'icon': Icons.compare_arrows_rounded,
      'title': 'Leverage Competitor Rates',
      'desc':
          'Mention "Bank X" offers 8.5%. Dealers often match rates to close the sale immediately.',
      'color': Colors.cyan,
    },
    {
      'icon': Icons.verified_user_rounded,
      'title': 'Highlight Credit Score',
      'desc':
          'Your score is in the top 10%. Use this as leverage to demand "Preferred Customer" pricing.',
      'color': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 700;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          //  Sophisticated Floating Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: _buildHeaderContent(),
              ),
            ),
          ),

          // 📄 Scrollable Advice Cards
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? screenWidth * 0.2 : 20,
              vertical: 30,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildAnimatedAdviceCard(index);
                },
                childCount: _adviceList.length,
              ),
            ),
          ),

          // Final Coaching Tip
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _buildProTipBox(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 40),
          Text(
            'Negotiation Strategy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Use these AI-generated insights to lower your costs.',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedAdviceCard(int index) {
    final item = _adviceList[index];

    // Staggered Fade-in Animation
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 150)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item['icon'], color: item['color']),
            ),
            title: Text(
              item['title'],
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            subtitle: const Text('Tap to see script',
                style: TextStyle(fontSize: 12, color: Colors.blue)),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 70, right: 20, bottom: 20),
                child: Text(
                  item['desc'],
                  style:
                      TextStyle(color: Colors.blueGrey.shade600, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProTipBox() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_rounded, color: Colors.orange, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Pro Tip',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.orange),
                ),
                Text(
                  'Always negotiate the "On-Road" price, not just the EMI.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
