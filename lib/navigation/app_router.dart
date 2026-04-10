import 'package:flutter/material.dart';
import 'package:telecom_app/views/gift/contact_page.dart';
import 'package:telecom_app/views/gift/gift_page.dart';
import 'package:telecom_app/views/home/dialog_page.dart';
import 'package:telecom_app/views/home/package_detail_multi_page.dart'; // Import màn hình Multi
import 'package:telecom_app/views/home/package_model.dart';
import '../views/auth/splash_page.dart';
import '../views/auth/welcome_page.dart';
import '../views/auth/login_page.dart';
import '../views/auth/register_page.dart';
import '../views/auth/otp_page.dart';
import '../views/home/home_page.dart';

class AppRouter {
  static const String success = '/success';
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String packageDetail = '/package-detail';
  static const String giftPackage = '/gift-package';
  static const String contactPicker = '/contact-picker';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case otp:
        if (settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => OtpPage(
              phoneNumber: args['phoneNumber'] ?? "",
              isRegister: args['isRegister'] ?? false,
              // 🎯 THÊM DÒNG NÀY: Để nhận tên từ màn Register truyền sang
              displayName: args['displayName'],
            ),
          );
        } else {
          // Trường hợp này thường là từ màn Login (chỉ truyền mỗi String SĐT)
          return MaterialPageRoute(
            builder: (_) => OtpPage(
              phoneNumber: settings.arguments as String,
              isRegister: false,
              displayName: null,
            ),
          );
        }

      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case giftPackage:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => GiftPage(package: args['package']),
        );
      case packageDetail:
        final args = settings.arguments;
        PackageModel package;
        bool isHistory = false;
        bool isExpired = false;
        bool isExchange = false;
        bool isGift = false; // 🎯 1. KHAI BÁO BIẾN Ở ĐÂY

        if (args is Map<String, dynamic>) {
          package = args['package'];
          isHistory = args['isHistory'] ?? false;
          isExpired = args['isExpired'] ?? false;
          isExchange = args['isExchange'] ?? false;
          isGift = args['isGift'] ?? false;
          // 🎯 2. LẤY TỪ ARGUMENTS
        } else {
          package = args as PackageModel;
          isHistory = false;
          isExpired = false;
          isExchange = false;
          isGift = false; // 🎯 Mặc định
        }

        return MaterialPageRoute(
          builder: (_) => PackageDetailMultiPage(
            package: package,
            isHistory: isHistory,
            isExpired: isExpired,
            isExchange: isExchange,
            isGift: isGift,
          ),
        );
      case contactPicker:
        return MaterialPageRoute(builder: (_) => const ContactPage());
      case success:
        {
          final args = settings.arguments;

          // 🎯 NẾU TRUYỀN NHIỀU THAM SỐ (BẰNG MAP)
          if (args is Map<String, dynamic>) {
            return MaterialPageRoute(
              builder: (_) => SuccessPage(
                package: args['package'],
                packageName: args['packageName'] ?? args['package'].title,
                transactionId: args['transactionId'] ?? "123456ABCD",
                isExchange: args['isExchange'] ?? false,
                isGift: args['isGift'] ?? false,
                recipientPhone: args['recipientPhone'],
              ),
            );
          }
          // 🎯 NẾU CHỈ TRUYỀN MỖI PACKAGE (Code cũ)
          else {
            final package = args as PackageModel;
            return MaterialPageRoute(
              builder: (_) => SuccessPage(
                package: package,
                packageName: package.title,
                transactionId: "123456ABCD", // Fallback mã gd
                isExchange: false,
                isGift: false,
              ),
            );
          }
        }
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Không tìm thấy đường dẫn: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
