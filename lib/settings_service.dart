import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _keyServerUrl = "server_url";
  static const defaultServerUrl = "http://192.168.1.101:5000";

  static Future<String> getServerUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyServerUrl) ?? defaultServerUrl;
  }

  static Future<void> setServerUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyServerUrl, url);
  }
}
