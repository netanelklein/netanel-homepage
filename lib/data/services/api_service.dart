import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/portfolio_data.dart';
import '../models/contact_message.dart';
import 'mock_data_service.dart';

enum LoadingState { idle, loading, success, error }

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message';
}

class ApiService {
  static const String _baseUrl =
      'https://api.netanelk.com'; // TODO: Replace with actual API URL
  static const Duration _timeout = Duration(seconds: 30);

  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  // Headers for API requests
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  /// Fetch complete portfolio data
  Future<PortfolioData> getPortfolioData() async {
    // Use mock data in debug mode
    if (kDebugMode) {
      return MockDataService.getPortfolioData();
    }

    try {
      final response = await _client
          .get(
            Uri.parse('$_baseUrl/portfolio'),
            headers: _headers,
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return PortfolioData.fromJson(jsonData);
      } else {
        throw ApiException(
          'Failed to load portfolio data: ${response.reasonPhrase}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  /// Fetch personal information only
  Future<Map<String, dynamic>> getPersonalInfo() async {
    try {
      final response = await _client
          .get(
            Uri.parse('$_baseUrl/personal-info'),
            headers: _headers,
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw ApiException(
          'Failed to load personal info: ${response.reasonPhrase}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  /// Fetch projects with optional filtering
  Future<List<Map<String, dynamic>>> getProjects({
    String? type,
    String? status,
    int? limit,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (type != null) queryParams['type'] = type;
      if (status != null) queryParams['status'] = status;
      if (limit != null) queryParams['limit'] = limit.toString();

      final uri = Uri.parse('$_baseUrl/projects').replace(
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      final response =
          await _client.get(uri, headers: _headers).timeout(_timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        return jsonData.cast<Map<String, dynamic>>();
      } else {
        throw ApiException(
          'Failed to load projects: ${response.reasonPhrase}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  /// Fetch skills grouped by category
  Future<List<Map<String, dynamic>>> getSkillCategories() async {
    try {
      final response = await _client
          .get(
            Uri.parse('$_baseUrl/skills'),
            headers: _headers,
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        return jsonData.cast<Map<String, dynamic>>();
      } else {
        throw ApiException(
          'Failed to load skills: ${response.reasonPhrase}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  /// Generate and download resume in specified format
  Future<List<int>> generateResume({
    String format = 'pdf', // 'pdf', 'docx', 'json'
    String template = 'modern', // 'modern', 'classic', 'minimal'
  }) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl/resume/generate'),
            headers: _headers,
            body: json.encode({
              'format': format,
              'template': template,
            }),
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw ApiException(
          'Failed to generate resume: ${response.reasonPhrase}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  /// Submit contact form
  Future<void> submitContactForm({
    required String name,
    required String email,
    required String message,
    String? subject,
  }) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl/contact'),
            headers: _headers,
            body: json.encode({
              'name': name,
              'email': email,
              'message': message,
              'subject': subject,
            }),
          )
          .timeout(_timeout);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          'Failed to submit contact form: ${response.reasonPhrase}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  /// Submit contact form message
  Future<bool> submitContactMessage(ContactMessage message) async {
    // In debug mode, simulate API call with mock success
    if (kDebugMode) {
      await Future.delayed(
          const Duration(seconds: 2)); // Simulate network delay
      return true; // Mock successful submission
    }

    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl/contact'),
            headers: _headers,
            body: json.encode(message.toJson()),
          )
          .timeout(_timeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw ApiException(
          'Failed to submit contact message: ${response.reasonPhrase}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  /// Close the HTTP client
  void dispose() {
    _client.close();
  }
}
