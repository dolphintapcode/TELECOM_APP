import 'package:flutter/material.dart';
import '../../../navigation/app_router.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  String? errorText;
  bool isLoading = false;

  // Logic kiểm tra số điện thoại
  void onPhoneChanged(String value) {
    if (value.length >= 10 && errorText != null) {
      errorText = null;
      notifyListeners();
    }
  }

  // Logic xử lý khi nhấn Tiếp tục
  Future<void> handleContinue(BuildContext context) async {
    String phoneNumber = phoneController.text.trim();

    if (phoneNumber.length < 10) {
      errorText = 'Số điện thoại phải có ít nhất 10 số';
      notifyListeners();
      return;
    }

    // Bắt đầu quá trình gửi mã
    isLoading = true;
    errorText = null;
    notifyListeners();

    // 1. Ẩn bàn phím
    FocusScope.of(context).unfocus();

    Future<void> handleContinue(BuildContext context) async {
      // ... check logic ...

      // 1. Dọn dẹp các SnackBar cũ nếu có
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // 2. Hiện thông báo với thời gian ngắn (ví dụ 1 giây)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đang gửi mã xác thực...'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1), // Chỉ hiện 1 giây thôi
          behavior: SnackBarBehavior.floating,
        ),
      );

      await Future.delayed(const Duration(milliseconds: 1000));

      if (!context.mounted) return;
      Navigator.pushNamed(context, AppRouter.otp, arguments: phoneNumber);
    }

    // 3. Giả lập gọi API (1.5 giây)
    await Future.delayed(const Duration(milliseconds: 1500));

    isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    // 4. Chuyển trang dùng Named Route (Đã định nghĩa trong AppRouter)
    Navigator.pushNamed(
      context,
      AppRouter.otp,
      arguments: phoneNumber, // Truyền số điện thoại sang OTP
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
