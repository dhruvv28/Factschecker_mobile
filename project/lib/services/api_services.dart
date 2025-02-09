import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _backendUrl = 'http://10.0.2.2:5000';  

  static Future<Map<String, dynamic>> factCheck(String query) async {
    try {
      final response = await http.post(
        Uri.parse('$_backendUrl/api/fact-check'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }
}