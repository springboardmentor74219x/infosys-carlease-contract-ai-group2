import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  // Upload contract
  static Future<void> uploadContractBytes(
      Uint8List bytes, String filename) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/upload"),
    );
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: filename,
      ),
    );
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception("Upload failed");
    }
  }

  // Get negotiation advice with contract details
  static Future<Map<String, dynamic>> getNegotiationAdviceWithDetails({
    required double apr,
    required int termMonths,
    required double monthlyPayment,
    required bool hasPenalty,
    required String riskFlag,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/negotiate"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "apr": apr,
        "term_months": termMonths,
        "monthly_payment": monthlyPayment,
        "has_penalty": hasPenalty,
        "risk_flag": riskFlag,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get negotiation advice");
    }
  }

  // Legacy method - kept for compatibility
  static Future<String> getNegotiationAdvice(String question) async {
    final response = await http.post(
      Uri.parse("$baseUrl/negotiate"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"question": question}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["advice"]?["main_advice"] ??
          data["reply"] ??
          "Unable to generate advice";
    } else {
      throw Exception("Failed to get negotiation advice");
    }
  }
}
