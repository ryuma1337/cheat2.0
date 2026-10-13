import 'package:flutter/material.dart';
import '../settings_service.dart';

class ServerSettingsPage extends StatefulWidget {
  const ServerSettingsPage({super.key});
  @override
  State<ServerSettingsPage> createState() => _ServerSettingsPageState();
}

class _ServerSettingsPageState extends State<ServerSettingsPage> {
  final _controller = TextEditingController();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final url = await SettingsService.getServerUrl();
    _controller.text = url;
    setState(() { _loaded = true; });
  }

  Future<void> _save() async {
    await SettingsService.setServerUrl(_controller.text.trim());
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("kaydedildi")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return const Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: Center(child: CircularProgressIndicator(color: Color(0xFFE53935))),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        foregroundColor: const Color(0xFFE53935),
        elevation: 0,
        title: const Text("SUNUCU AYARLARI", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("uygulamanin baglanacagi sunucu adresi", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Sunucu URL",
                hintText: "http://192.168.1.101:5000",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Color(0xFFE53935)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _save,
              child: const Text("KAYDET", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
            ),
          ],
        ),
      ),
    );
  }
}
