import 'package:flutter/material.dart';
import 'negotiation_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF), // Ultra-light blue base
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          //  Modern App Bar with Gradient
          SliverAppBar(
            expandedHeight: 180,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color(0xFF1976D2),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: _buildHeaderContent(),
              ),
              title: screenWidth < 600 ? const Text('Dashboard') : null,
              centerTitle: true,
            ),
          ),

          //  Content Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? screenWidth * 0.2 : 20,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Active Contract'),
                  const SizedBox(height: 16),

                  // Main Info Card
                  _buildMainInfoCard(),

                  const SizedBox(height: 32),
                  _buildSectionTitle('Financial Breakdown'),
                  const SizedBox(height: 16),

                  // Secondary Data Grid
                  _buildQuickStats(isDesktop),

                  const SizedBox(height: 40),

                  //  CTA Button with Hover Interaction
                  _buildNegotiationButton(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.auto_graph_rounded, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            'Welcome, Arjun 👋',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const Text(
            'Heres what we found in your car loan contract.',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: Colors.blueGrey.shade800,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildMainInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blue.shade50.withOpacity(0.5),
              child: const _InfoRow(
                icon: Icons.directions_car_filled_rounded,
                label: 'Selected Vehicle',
                value: 'Premium SUV',
                isHeader: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: const [
                  _InfoRow(
                      icon: Icons.person_outline,
                      label: 'Account Holder',
                      value: 'Arjun Patel'),
                  Divider(height: 32),
                  _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Loan Tenure',
                      value: '72 Months'),
                  Divider(height: 32),
                  _InfoRow(
                      icon: Icons.verified_user_outlined,
                      label: 'Status',
                      value: 'Ready to Negotiate'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(bool isDesktop) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildStatTile(
            'Monthly EMI', '₹27,500', Icons.currency_rupee, Colors.blue),
        _buildStatTile('Interest Rate', '10.8%', Icons.percent, Colors.indigo),
      ],
    );
  }

  Widget _buildStatTile(
      String label, String value, IconData icon, Color color) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildNegotiationButton(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: _isHovering
            ? (Matrix4.identity()..scale(1.02))
            : Matrix4.identity(),
        child: Container(
          width: double.infinity,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                colors: [Color(0xFF1A237E), Color(0xFF3F51B5)]),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3F51B5).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            icon: const Icon(Icons.bolt_rounded, color: Colors.white),
            label: const Text(
              'Analyze Negotiation Strategy',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NegotiationScreen()),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isHeader;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,
            color: isHeader ? Colors.blue : Colors.blueGrey.shade300, size: 22),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: isHeader ? Colors.blue.shade900 : Colors.blueGrey,
            fontWeight: isHeader ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: isHeader ? 18 : 15,
            fontWeight: FontWeight.bold,
            color: isHeader ? Colors.blue.shade900 : Colors.black87,
          ),
        ),
      ],
    );
  }
}
