import 'dart:convert';
import 'package:http/http.dart' as http;
import 'log_model.dart';
import 'settings_service.dart';

class Api {
  static const String key = "ryuma_secret_2026";

  static Future<List<LogEntry>> fetchLogs() async {
    final base = await SettingsService.getServerUrl();
    final res = await http.get(Uri.parse("$base/api/logs?key=$key")).timeout(const Duration(seconds: 5));
    if (res.statusCode != 200) throw Exception("api error");
    final List data = jsonDecode(res.body);
    return data.map((e) => LogEntry.fromJson(e)).toList();
  }
}
