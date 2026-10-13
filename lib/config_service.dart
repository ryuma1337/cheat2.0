import 'dart:convert';
import 'package:flutter/services.dart';
import 'config_model.dart';

class ConfigService {
  static Future<AppConfig> load() async {
    try {
      final raw = await rootBundle.loadString('assets/config.json');
      final data = jsonDecode(raw);
      return AppConfig.fromJson(data);
    } catch (_) {
      return AppConfig.fallback();
    }
  }
}
