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

  // Get negotiation advice
  static Future<String> getNegotiationAdvice(String question) async {
    final response = await http.post(
      Uri.parse("$baseUrl/negotiate"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"question": question}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["reply"];
    } else {
      throw Exception("Failed to get negotiation advice");
    }
  }
}
