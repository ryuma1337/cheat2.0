import 'dart:convert';
import 'package:http/http.dart' as http;
import 'log_model.dart';

class Api {
  static const String baseUrl = "http://192.168.1.100:5000";
  static const String key = "ryuma_secret_2026";

  static Future<List<LogEntry>> fetchLogs() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/logs?key=$key"),
    );
    if (res.statusCode != 200) throw Exception("api error");
    final List data = jsonDecode(res.body);
    return data.map((e) => LogEntry.fromJson(e)).toList();
  }
}
