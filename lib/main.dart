import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Phải có cái này
import 'my_app.dart';
import 'views/auth/splash_provider.dart'; // 2. Kiểm tra kỹ tên file này

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SplashProvider())],
      child: const MyApp(),
    ),
  );
}
