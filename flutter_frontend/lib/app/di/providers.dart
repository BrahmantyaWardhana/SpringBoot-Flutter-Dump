import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppConfig {
  final String appTitle;
  final String apiBaseUrl;
  const AppConfig({
    this.appTitle = 'Flutter Demo',
    this.apiBaseUrl = 'http://localhost:8080',
  });
}

final appConfigProvider = Provider<AppConfig>((ref) {
  return const AppConfig();
});

