import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telecom_app/views/ExchangePoint/exchange_provider.dart';
import 'package:telecom_app/views/gift/gift_provider.dart';
import 'package:telecom_app/views/history/history_provider.dart';
import 'package:telecom_app/views/home/package_provider.dart';
import 'package:telecom_app/views/notifications/notification_provider.dart';

// --- IMPORT PROVIDERS (Logic - Nhớ check kỹ tên folder) ---
import 'views/auth/splash_provider.dart';
import 'views/auth/login_provider.dart';
import 'views/auth/otp_provider.dart';
import 'views/auth/register_provider.dart';
import 'views/home/home_provider.dart';

// --- IMPORT NAVIGATION & THEME ---
// Trung kiểm tra xem tên file là route_handler.dart hay app_router.dart nhé
import 'navigation/app_router.dart';
import 'core/themes/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => PackageProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => ExchangeProvider()),
        ChangeNotifierProvider(create: (_) => GiftProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Telecom App',
        initialRoute: AppRouter.home,
        // Cấu hình Theme sử dụng AppColors Trung đã định nghĩa
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: AppColors.primary,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
          ),
          scaffoldBackgroundColor: AppColors.background,
          // Thêm font chữ chung nếu Trung có dùng Google Fonts
        ),

        // QUAN TRỌNG: Kết nối với AppRouter
        // initialRoute mặc định là '/' (tương ứng với SplashPage trong AppRouter)
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
