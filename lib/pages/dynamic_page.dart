import 'package:flutter/material.dart';

class DynamicPage extends StatelessWidget {
  final String title;
  final String content;
  const DynamicPage({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        foregroundColor: const Color(0xFFE53935),
        elevation: 0,
        title: Text(title.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
      ),
    );
  }
}
