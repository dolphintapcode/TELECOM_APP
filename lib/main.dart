import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// 🎯 1. Import 2 thư viện này vào
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'my_app.dart';
import 'views/auth/splash_provider.dart';
import 'views/auth/auth_provider.dart';

// 🎯 2. Đổi 'void main()' thành 'void main() async'
void main() async {
  // 🎯 3. BẮT BUỘC phải có dòng này để Flutter chuẩn bị nền tảng
  WidgetsFlutterBinding.ensureInitialized();

  // 🎯 4. Khởi tạo Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 5. Chạy App của ông như bình thường
  runApp(
    MultiProvider(
      providers: [
        // Chỗ này tôi thấy ông đang cấu hình dở SplashProvider, cứ giữ nguyên nhé
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
