import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('🧪 Testing API service directly...');

  try {
    const baseUrl = 'http://localhost:8000/api';
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    print('🌐 Making API request to: $baseUrl/portfolio');

    final response = await http.get(
      Uri.parse('$baseUrl/portfolio'),
      headers: headers,
    );

    print('📡 API Response status: ${response.statusCode}');
    print('📡 API Response headers: ${response.headers}');

    if (response.statusCode == 200) {
      print('✅ API Response received, parsing JSON...');
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      print('📄 JSON keys: ${jsonData.keys.toList()}');
      print('🎉 API call successful!');

      // Check personal info
      if (jsonData.containsKey('personalInfo')) {
        final personalInfo = jsonData['personalInfo'];
        print('👤 Name: ${personalInfo['fullName']}');
        print('💼 Title: ${personalInfo['title']}');
      }

      // Check projects count
      if (jsonData.containsKey('projects')) {
        final projects = jsonData['projects'] as List;
        print('🚀 Projects count: ${projects.length}');
      }
    } else {
      print('❌ API Error: ${response.statusCode} - ${response.reasonPhrase}');
      print('❌ Response body: ${response.body}');
    }
  } catch (e) {
    print('💥 Exception caught: $e');
  }
}
