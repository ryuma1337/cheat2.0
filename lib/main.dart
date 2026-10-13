import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'api.dart';
import 'log_model.dart';

void main() => runApp(const RyumaApp());

class RyumaApp extends StatelessWidget {
  const RyumaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ryuma Cheating',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        primaryColor: const Color(0xFFE53935),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF111111),
          foregroundColor: Color(0xFFE53935),
          elevation: 0,
        ),
      ),
      home: const LogsPage(),
    );
  }
}

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});
  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  List<LogEntry> logs = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() { loading = true; error = null; });
    try {
      final data = await Api.fetchLogs();
      setState(() { logs = data; loading = false; });
    } catch (e) {
      setState(() { error = e.toString(); loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RYUMA CHEATING", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: load),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFE53935)))
          : error != null
              ? Center(child: Text("hata: $error", style: const TextStyle(color: Colors.red)))
              : logs.isEmpty
                  ? const Center(child: Text("henüz log yok"))
                  : ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: logs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) => LogCard(logs[i]),
                    ),
    );
  }
}

class LogCard extends StatelessWidget {
  final LogEntry log;
  const LogCard(this.log, {super.key});

  String _formatTime(String ts) {
    try {
      final dt = DateTime.parse(ts);
      return DateFormat('dd/MM/yyyy HH:mm:ss').format(dt);
    } catch (_) { return ts; }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE53935).withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person, color: Color(0xFFE53935), size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(log.ip, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              Text(_formatTime(log.timestamp), style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
          const Divider(color: Colors.white12, height: 16),
          _row("platform", log.platform),
          _row("lang", log.language),
          _row("screen", log.screen),
          _row("tz", log.timezone),
          if (log.latitude != null && log.longitude != null)
            _row("konum", "${log.latitude}, ${log.longitude}"),
          const SizedBox(height: 6),
          Text(log.userAgent,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _row(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 70, child: Text(k, style: const TextStyle(color: Colors.grey, fontSize: 12))),
          Expanded(child: Text(v, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
