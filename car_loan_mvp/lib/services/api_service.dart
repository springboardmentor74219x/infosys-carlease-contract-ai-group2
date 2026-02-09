import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";
  static const Duration timeout = Duration(seconds: 30);

  static Future<bool> uploadContract(Uint8List bytes, String filename) async {
    try {
      var uri = Uri.parse("$baseUrl/upload");
      var request = MultipartRequest("POST", uri);

      request.files.add(
        MultipartFile.fromBytes(
          "file",
          bytes,
          filename: filename,
        ),
      );

      var response = await request.send().timeout(timeout);
      return response.statusCode == 200;
    } catch (e) {
      print("Upload error: $e");
      return false;
    }
  }

  static Future<String> negotiate(String question) async {
    try {
      var uri = Uri.parse("$baseUrl/negotiate");

      var response = await http
          .post(
            uri,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"question": question}),
          )
          .timeout(timeout);

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("Parsed response: $jsonResponse");

        // Try to extract negotiation_advice
        if (jsonResponse is Map) {
          if (jsonResponse.containsKey("negotiation_advice")) {
            final advice = jsonResponse["negotiation_advice"];
            if (advice != null && advice is String) {
              return advice;
            }
          }
        }

        return "Based on your EMI and interest rate, you can negotiate a lower APR by highlighting your stable income, credit score, and comparing offers from other lenders.";
      } else {
        return "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      print("Negotiate error: $e");
      return "Based on your EMI and interest rate, you can negotiate a lower APR by highlighting your stable income, credit score, and comparing offers from other lenders.";
    }
  }

  // Optional: Add a method to get full contract data
  static Future<Map<String, dynamic>?> getContractAnalysis() async {
    try {
      var uri = Uri.parse("$baseUrl/negotiate");

      var response = await http
          .post(
            uri,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"question": "Analyze my car loan contract"}),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print("Analysis error: $e");
      return null;
    }
  }
}
