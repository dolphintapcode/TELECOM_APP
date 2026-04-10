import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 🎯 Cần thêm dòng này để gọi Provider
import '../../../navigation/app_router.dart';
import 'package:telecom_app/views/auth/auth_provider.dart';

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

    // Bắt đầu quá trình load
    isLoading = true;
    errorText = null;
    notifyListeners();

    // 1. Ẩn bàn phím & dọn dẹp thông báo cũ
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // 🎯 2. KẾT NỐI FIREBASE: Gọi AuthProvider để kiểm tra SĐT
    final authProvider = context.read<AuthProvider>();
    bool isExist = await authProvider.checkPhoneExists(phoneNumber);

    // Dừng vòng xoay load
    isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    // 🎯 3. XỬ LÝ LOGIC ĐIẾU HƯỚNG
    if (isExist) {
      // TRƯỜNG HỢP 1: SĐT ĐÃ CÓ TRONG DATABASE
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đang gửi mã xác thực...'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.fromLTRB(16, 0, 16, 120),
        ),
      );

      // Chuyển trang sang OTP
      Navigator.pushNamed(context, AppRouter.otp, arguments: phoneNumber);
    } else {
      // TRƯỜNG HỢP 2: SĐT CHƯA TỒN TẠI
      errorText = 'Số điện thoại này chưa được đăng ký!';
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng sang trang đăng ký để tạo tài khoản'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.fromLTRB(16, 0, 16, 120),
        ),
      );
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
