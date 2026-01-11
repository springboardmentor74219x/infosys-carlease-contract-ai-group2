import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<bool> uploadContract(Uint8List bytes, String filename) async {
    var uri = Uri.parse("$baseUrl/upload");
    var request = MultipartRequest("POST", uri);

    request.files.add(
      MultipartFile.fromBytes(
        "file",
        bytes,
        filename: filename,
      ),
    );

    var response = await request.send();
    return response.statusCode == 200;
  }

  static Future<String> negotiate(String question) async {
    var uri = Uri.parse("$baseUrl/negotiate");

    var response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"question": question}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["reply"];
    }
    return "Error getting negotiation advice";
  }
}
