import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'config_model.dart';
import 'settings_service.dart';

class ConfigService {
  static Future<AppConfig> load() async {
    try {
      final base = await SettingsService.getServerUrl();
      final res = await http.get(Uri.parse("$base/config")).timeout(const Duration(seconds: 3));
      if (res.statusCode == 200) {
        return AppConfig.fromJson(jsonDecode(res.body));
      }
    } catch (_) {}
    try {
      final raw = await rootBundle.loadString('assets/config.json');
      return AppConfig.fromJson(jsonDecode(raw));
    } catch (_) {
      return AppConfig.fallback();
    }
  }
}
