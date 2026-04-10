import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../navigation/app_router.dart';
// 🎯 Import AuthProvider và UserModel của ông
import 'package:telecom_app/views/auth/auth_provider.dart';

class OtpProvider extends ChangeNotifier {
  bool isLoading = false;
  int resendSeconds = 60;
  Timer? _timer;

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

  // 🎯 CẬP NHẬT LOGIC XÁC THỰC OTP
  Future<void> verifyOtp(
    BuildContext context,
    String pin, {
    required String phoneNumber, // Nhận SĐT từ arguments
    String? displayName, // Nhận Tên từ arguments (nếu có)
    bool isRegister = false,
  }) async {
    isLoading = true;
    notifyListeners();

    // 🎯 GIẢ LẬP NHẬP ĐÚNG MÃ (Tí nữa ông tích hợp Firebase Phone Auth thật sau nhé)
    final authProvider = context.read<AuthProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final isContextMounted = context.mounted;
    await Future.delayed(const Duration(milliseconds: 1000));

    if (pin == "123456") {
      if (isRegister) {
        // --- LUỒNG ĐĂNG KÝ: LƯU VÀO FIREBASE ---
        bool success = await authProvider.registerUser(
          name: displayName ?? "Người dùng",
          phone: phoneNumber,
          uid:
              "UID_${DateTime.now().millisecondsSinceEpoch}", // Tạm thời tạo UID giả
        );

        isLoading = false;
        notifyListeners();

        if (success && isContextMounted) {
          messenger.showSnackBar(
            const SnackBar(
              content: Text("Đăng ký thành công! Hãy đăng nhập."),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
          navigator.pushNamedAndRemoveUntil(AppRouter.login, (route) => false);
        } else if (isContextMounted) {
          messenger.showSnackBar(
            const SnackBar(
              content: Text("Lỗi lưu dữ liệu. Thử lại sau!"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        // --- LUỒNG ĐĂNG NHẬP: LẤY DỮ LIỆU USER VỀ ---
        bool success = await authProvider.loginUser(phone: phoneNumber);

        isLoading = false;
        notifyListeners();

        if (success && isContextMounted) {
          navigator.pushNamedAndRemoveUntil(AppRouter.home, (route) => false);
        } else if (isContextMounted) {
          messenger.showSnackBar(
            const SnackBar(
              content: Text("Đăng nhập thất bại. Vui lòng thử lại."),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } else if (isContextMounted) {
      isLoading = false;
      notifyListeners();
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Mã OTP không đúng"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
