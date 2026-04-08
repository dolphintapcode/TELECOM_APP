import 'package:flutter/material.dart';
import '../../../navigation/app_router.dart';

class SplashProvider extends ChangeNotifier {
  void initSplash(BuildContext context) async {
    // 1. Đếm ngược 2.5 giây
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!context.mounted) return;

    // 2. Logic kiểm tra Login (Tạm thời cho false để ra Welcome)

    // 3. Điều hướng dùng Named Route
    Navigator.pushReplacementNamed(context, AppRouter.welcome);
    //Navigator.pushReplacementNamed(context, AppRouter.home);
  }
}
