import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ContractData {
  final String customerName;
  final String vehicle;
  final String monthlyEmi;
  final String interestRate;
  final String tenureMonths;
  final String riskFlag;
  final String issueType;
  final String recommendedAction;
  final String negotiationAdvice;

  ContractData({
    required this.customerName,
    required this.vehicle,
    required this.monthlyEmi,
    required this.interestRate,
    required this.tenureMonths,
    required this.riskFlag,
    required this.issueType,
    required this.recommendedAction,
    required this.negotiationAdvice,
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Always show contract details by default
  late ContractData contractData = ContractData(
    customerName: 'Arjun Patel',
    vehicle: 'SUV',
    monthlyEmi: '₹27,500',
    interestRate: '10.8%',
    tenureMonths: '72 months',
    riskFlag: 'Medium',
    issueType: 'High Interest Rate',
    recommendedAction: 'Negotiate for a lower APR or shorter tenure',
    negotiationAdvice: '', // Will be filled when user clicks button
  );

  bool isLoading = false;
  String? negotiationAdvice;

  void analyzeContract() async {
    setState(() {
      isLoading = true;
      negotiationAdvice = null;
    });

    try {
      print("Starting negotiation analysis...");
      String response =
          await ApiService.negotiate("How can I negotiate my car loan?");

      print("Received response: $response");

      setState(() {
        contractData = ContractData(
          customerName: contractData.customerName,
          vehicle: contractData.vehicle,
          monthlyEmi: contractData.monthlyEmi,
          interestRate: contractData.interestRate,
          tenureMonths: contractData.tenureMonths,
          riskFlag: contractData.riskFlag,
          issueType: contractData.issueType,
          recommendedAction: contractData.recommendedAction,
          negotiationAdvice: response,
        );
        negotiationAdvice = response;
        isLoading = false;
      });
    } catch (e) {
      print("Error in analyzeContract: $e");
      setState(() {
        isLoading = false;
        negotiationAdvice =
            "Error: Unable to get negotiation advice. Please make sure your backend server is running on http://127.0.0.1:8000";
      });

      // Show error snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contract Analysis"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Contract Details Section - ALWAYS VISIBLE
            _buildSectionCard(
              title: 'Contract Details',
              icon: Icons.description_outlined,
              child: _buildContractDetailsTable(),
            ),
            const SizedBox(height: 16),

            // Risk Assessment (SLA) Section - ALWAYS VISIBLE
            _buildSectionCard(
              title: 'Risk Assessment (SLA)',
              icon: Icons.warning_amber_rounded,
              child: _buildRiskAssessmentTable(),
            ),
            const SizedBox(height: 16),

            // Analyze Contract Button - ALWAYS VISIBLE
            ElevatedButton.icon(
              onPressed: isLoading ? null : analyzeContract,
              icon: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.assessment_outlined),
              label: Text(
                isLoading ? 'Analyzing...' : 'Get Negotiation Advice',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Negotiation Advice Section - ONLY IF AVAILABLE
            if (negotiationAdvice != null && negotiationAdvice!.isNotEmpty)
              _buildSectionCard(
                title: 'Negotiation Advice',
                icon: Icons.lightbulb_outline,
                child: _buildNegotiationAdvice(),
              ),

            // If no advice yet, show placeholder
            if (negotiationAdvice == null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Click "Get Negotiation Advice" to see personalized negotiation tips',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : analyzeContract,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: const Color(0xFF0F4C75),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F4C75),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildContractDetailsTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1.2),
      },
      children: [
        _buildTableRow(
          'Customer Name',
          contractData.customerName,
          isHeader: true,
        ),
        _buildTableRow(
          'Vehicle Type',
          contractData.vehicle,
        ),
        _buildTableRow(
          'Monthly EMI',
          contractData.monthlyEmi,
        ),
        _buildTableRow(
          'Interest Rate',
          contractData.interestRate,
        ),
        _buildTableRow(
          'Tenure',
          contractData.tenureMonths,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildRiskAssessmentTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1.2),
      },
      children: [
        _buildTableRow(
          'Risk Level',
          contractData.riskFlag,
          isHeader: true,
          riskLevel: contractData.riskFlag,
        ),
        _buildTableRow(
          'Issue Type',
          contractData.issueType,
        ),
        _buildTableRow(
          'Recommended Action',
          contractData.recommendedAction,
          isLast: true,
        ),
      ],
    );
  }

  TableRow _buildTableRow(
    String label,
    String value, {
    bool isHeader = false,
    bool isLast = false,
    String? riskLevel,
  }) {
    Color? riskColor;
    if (riskLevel != null) {
      if (riskLevel.toLowerCase() == 'high') {
        riskColor = Colors.red;
      } else if (riskLevel.toLowerCase() == 'medium') {
        riskColor = Colors.orange;
      } else if (riskLevel.toLowerCase() == 'low') {
        riskColor = Colors.green;
      }
    }

    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: isLast ? 0 : 1,
          ),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isHeader ? FontWeight.w600 : FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: riskColor != null
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: riskColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: riskColor.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: riskColor,
                    ),
                  ),
                )
              : Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isHeader ? FontWeight.w600 : FontWeight.w500,
                    color: Colors.grey[900],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildNegotiationAdvice() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F4C75).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF0F4C75).withOpacity(0.2),
        ),
      ),
      child: Text(
        negotiationAdvice ?? '',
        style: TextStyle(
          fontSize: 14,
          height: 1.8,
          color: Colors.grey[800],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
