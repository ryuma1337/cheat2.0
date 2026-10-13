class LogEntry {
  final int id;
  final String ip;
  final String userAgent;
  final String platform;
  final String language;
  final String screen;
  final String timezone;
  final String? latitude;
  final String? longitude;
  final String timestamp;

  LogEntry({
    required this.id,
    required this.ip,
    required this.userAgent,
    required this.platform,
    required this.language,
    required this.screen,
    required this.timezone,
    this.latitude,
    this.longitude,
    required this.timestamp,
  });

  factory LogEntry.fromJson(Map<String, dynamic> j) {
    return LogEntry(
      id: j['id'] ?? 0,
      ip: j['ip'] ?? '',
      userAgent: j['user_agent'] ?? '',
      platform: j['platform'] ?? '',
      language: j['language'] ?? '',
      screen: j['screen'] ?? '',
      timezone: j['timezone'] ?? '',
      latitude: j['latitude'],
      longitude: j['longitude'],
      timestamp: j['timestamp'] ?? '',
    );
  }
}
