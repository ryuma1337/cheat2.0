import 'package:flutter/material.dart';
import 'config_model.dart';
import 'config_service.dart';
import 'pages/dynamic_page.dart';
import 'pages/logs_page.dart';
import 'pages/server_settings_page.dart';

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
      ),
      home: const BootPage(),
    );
  }
}

class BootPage extends StatefulWidget {
  const BootPage({super.key});
  @override
  State<BootPage> createState() => _BootPageState();
}

class _BootPageState extends State<BootPage> {
  AppConfig? config;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final c = await ConfigService.load();
    setState(() { config = c; });
  }

  @override
  Widget build(BuildContext context) {
    if (config == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: Center(child: CircularProgressIndicator(color: Color(0xFFE53935))),
      );
    }
    return HomePage(config: config!);
  }
}

class HomePage extends StatelessWidget {
  final AppConfig config;
  const HomePage({super.key, required this.config});

  IconData _iconFor(String name) {
    switch (name) {
      case 'list': return Icons.list;
      case 'person': return Icons.person;
      case 'settings': return Icons.settings;
      case 'info': return Icons.info;
      case 'home': return Icons.home;
      case 'star': return Icons.star;
      default: return Icons.circle;
    }
  }

  void _open(BuildContext context, MenuItem item) {
    if (item.type == 'logs') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const LogsPage()));
    } else if (item.id == 'settings') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ServerSettingsPage()));
    } else {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => DynamicPage(title: item.title, content: item.content ?? ''),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        foregroundColor: const Color(0xFFE53935),
        elevation: 0,
        title: Text(config.appName.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: config.menu.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final item = config.menu[i];
          return InkWell(
            onTap: () => _open(context, item),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF141414),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE53935).withOpacity(0.3)),
              ),
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Icon(_iconFor(item.icon), color: const Color(0xFFE53935), size: 26),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        if (item.subtitle.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(item.subtitle,
                                style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
