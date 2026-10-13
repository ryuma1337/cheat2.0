import 'dart:convert';

class MenuItem {
  final String id;
  final String title;
  final String subtitle;
  final String icon;
  final String type;
  final String? content;

  MenuItem({
    required this.id,
    required this.title,
    this.subtitle = '',
    this.icon = 'circle',
    this.type = 'page',
    this.content,
  });

  factory MenuItem.fromJson(Map<String, dynamic> j) {
    return MenuItem(
      id: j['id'] ?? '',
      title: j['title'] ?? '',
      subtitle: j['subtitle'] ?? '',
      icon: j['icon'] ?? 'circle',
      type: j['type'] ?? 'page',
      content: j['content'],
    );
  }
}

class AppConfig {
  final String appName;
  final String primaryColor;
  final String backgroundColor;
  final String cardColor;
  final List<MenuItem> menu;

  AppConfig({
    required this.appName,
    required this.primaryColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.menu,
  });

  factory AppConfig.fromJson(Map<String, dynamic> j) {
    final theme = j['theme'] ?? {};
    final menuList = (j['menu'] as List? ?? [])
        .map((e) => MenuItem.fromJson(e))
        .toList();
    return AppConfig(
      appName: j['app_name'] ?? 'Ryuma Cheating',
      primaryColor: theme['primary'] ?? '#E53935',
      backgroundColor: theme['background'] ?? '#0A0A0A',
      cardColor: theme['card'] ?? '#141414',
      menu: menuList,
    );
  }

  static AppConfig fallback() {
    return AppConfig(
      appName: 'Ryuma Cheating',
      primaryColor: '#E53935',
      backgroundColor: '#0A0A0A',
      cardColor: '#141414',
      menu: [],
    );
  }
}
