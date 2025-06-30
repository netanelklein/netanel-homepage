import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/portfolio_data.dart';
import '../models/contact_message.dart';
import '../services/api_service.dart';

class PortfolioRepository extends ChangeNotifier {
  final ApiService _apiService;
  static const String _cacheKey = 'portfolio_data_cache';
  static const String _cacheTimestampKey = 'portfolio_cache_timestamp';
  static const Duration _cacheExpiry = Duration(hours: 1);

  PortfolioData? _portfolioData;
  LoadingState _loadingState = LoadingState.idle;
  String? _errorMessage;

  PortfolioRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  // Getters
  PortfolioData? get portfolioData => _portfolioData;
  LoadingState get loadingState => _loadingState;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _loadingState == LoadingState.loading;
  bool get hasError => _loadingState == LoadingState.error;
  bool get hasData => _portfolioData != null;

  /// Load portfolio data with caching
  Future<void> loadPortfolioData({bool forceRefresh = false}) async {
    try {
      _setLoadingState(LoadingState.loading);

      // Try to load from cache first if not forcing refresh
      if (!forceRefresh) {
        final cachedData = await _loadFromCache();
        if (cachedData != null) {
          _portfolioData = cachedData;
          _setLoadingState(LoadingState.success);
          return;
        }
      }

      // Fetch from API
      final data = await _apiService.getPortfolioData();
      _portfolioData = data;

      // Cache the data
      await _saveToCache(data);

      _setLoadingState(LoadingState.success);
      
    } catch (e) {
      _errorMessage = e.toString();
      _setLoadingState(LoadingState.error);

      // Try to load from cache as fallback
      if (_portfolioData == null) {
        final cachedData = await _loadFromCache();
        if (cachedData != null) {
          _portfolioData = cachedData;
          _setLoadingState(LoadingState.success);
        }
      }
    }
  }

  /// Refresh portfolio data from API
  Future<void> refresh() async {
    await loadPortfolioData(forceRefresh: true);
  }

  /// Generate resume with specified format and template
  Future<List<int>?> generateResume({
    String format = 'pdf',
    String template = 'modern',
  }) async {
    try {
      return await _apiService.generateResume(
        format: format,
        template: template,
      );
    } catch (e) {
      _errorMessage = e.toString();
      return null;
    }
  }

  /// Submit contact form
  Future<bool> submitContactForm({
    required String name,
    required String email,
    required String message,
    String? subject,
  }) async {
    try {
      await _apiService.submitContactForm(
        name: name,
        email: email,
        message: message,
        subject: subject,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  /// Submit contact message via API
  Future<bool> submitContactMessage(ContactMessage message) async {
    try {
      return await _apiService.submitContactMessage(message);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to submit contact message: $e');
      }
      return false;
    }
  }

  /// Clear cache and reload
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
    await prefs.remove(_cacheTimestampKey);
    await loadPortfolioData(forceRefresh: true);
  }

  /// Load data from cache if available and not expired
  Future<PortfolioData?> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString(_cacheKey);
      final timestampMs = prefs.getInt(_cacheTimestampKey);

      if (cachedJson == null || timestampMs == null) {
        return null;
      }

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestampMs);
      final now = DateTime.now();
      final cacheAge = now.difference(cacheTime);

      // Check if cache is expired
      if (cacheAge > _cacheExpiry) {
        return null;
      }

      final jsonData = json.decode(cachedJson) as Map<String, dynamic>;
      final portfolioData = PortfolioData.fromJson(jsonData);
      
      return portfolioData;
    } catch (e) {
      return null;
    }
  }

  /// Save data to cache with timestamp
  Future<void> _saveToCache(PortfolioData data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(data.toJson());
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      await prefs.setString(_cacheKey, jsonString);
      await prefs.setInt(_cacheTimestampKey, timestamp);
    } catch (e) {
      // Cache saving failure is not critical
      if (kDebugMode) {
        print('Cache saving failed: $e');
      }
    }
  }

  /// Update loading state and notify listeners
  void _setLoadingState(LoadingState state) {
    _loadingState = state;
    if (state != LoadingState.error) {
      _errorMessage = null;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }
}
