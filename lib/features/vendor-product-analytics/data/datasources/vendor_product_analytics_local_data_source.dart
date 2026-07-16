import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/vendor_product_analytics_model.dart';

abstract class VendorProductAnalyticsLocalDataSource {
  Future<VendorProductAnalyticsModel?> getCachedAnalytics(String cacheKey);
  Future<void> cacheAnalytics(String cacheKey, VendorProductAnalyticsModel model);
}

class VendorProductAnalyticsLocalDataSourceImpl
    implements VendorProductAnalyticsLocalDataSource {
  static const _prefix = 'vendor_product_analytics_';

  Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  @override
  Future<VendorProductAnalyticsModel?> getCachedAnalytics(String cacheKey) async {
    final prefs = await _prefs;
    final jsonString = prefs.getString('$_prefix$cacheKey');
    if (jsonString == null || jsonString.isEmpty) return null;

    try {
      final Map<String, dynamic> decoded =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return VendorProductAnalyticsModel.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheAnalytics(
    String cacheKey,
    VendorProductAnalyticsModel model,
  ) async {
    final prefs = await _prefs;
    final encoded = jsonEncode(model.toJson());
    await prefs.setString('$_prefix$cacheKey', encoded);
  }
}
