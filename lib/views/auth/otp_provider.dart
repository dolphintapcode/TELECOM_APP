import 'dart:async';
import 'package:flutter/material.dart';
import '../../../navigation/app_router.dart';

class OtpProvider extends ChangeNotifier {
  bool isLoading = false;
  int resendSeconds = 60; // Bộ đếm ngược 60 giây
  Timer? _timer;

  // Khởi tạo bộ đếm ngược ngay khi vào trang
  void startResendTimer() {
    resendSeconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds > 0) {
        resendSeconds--;
        notifyListeners();
      } else {
        _timer?.cancel();
      }
    });
  }

  // Logic xác thực OTP
  Future<void> verifyOtp(
    BuildContext context,
    String pin, {
    bool isRegister = false, // Cờ nhận diện luồng
  }) async {
    isLoading = true;
    notifyListeners();
    final currentContext = context;
    await Future.delayed(const Duration(milliseconds: 1000));

    if (pin == "123456") {
      isLoading = false;
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }

      // KIỂM TRA LUỒNG ĐỂ ĐIỀU HƯỚNG ĐÚNG FIGMA
      if (isRegister) {
        // LUỒNG ĐĂNG KÝ: Hiện thông báo và quay về Login để người dùng đăng nhập lại
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Đăng ký thành công! Hãy đăng nhập để bắt đầu."),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouter.login, // Quay về Login
          (route) => false,
        );
      } else {
        // LUỒNG ĐĂNG NHẬP: Vào thẳng trang Home
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouter.home, // Vào Home
          (route) => false,
        );
      }
    } else {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mã OTP không đúng"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSnackBar(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
