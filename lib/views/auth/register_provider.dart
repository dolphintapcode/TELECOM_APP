import 'package:flutter/material.dart';
import '../../../navigation/app_router.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String? phoneErrorText;
  String? nameErrorText;
  bool isLoading = false;

  // Lắng nghe thay đổi số điện thoại để xóa lỗi
  void onPhoneChanged(String value) {
    if (value.length >= 10 && phoneErrorText != null) {
      phoneErrorText = null;
      notifyListeners();
    }
  }

  // Lắng nghe thay đổi tên để xóa lỗi
  void onNameChanged(String value) {
    if (value.isNotEmpty && nameErrorText != null) {
      nameErrorText = null;
      notifyListeners();
    }
  }

  // Xử lý logic Đăng ký
  Future<void> handleRegister(BuildContext context) async {
    String phoneNumber = phoneController.text.trim();
    String name = nameController.text.trim();

    // Reset lỗi
    phoneErrorText = null;
    nameErrorText = null;

    if (phoneNumber.length < 10 || name.isEmpty) {
      if (phoneNumber.length < 10) {
        phoneErrorText = 'Số điện thoại phải có ít nhất 10 số';
      }
      if (name.isEmpty) {
        nameErrorText = 'Vui lòng nhập tên của bạn';
      }
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang gửi mã xác thực tới $phoneNumber...'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1), // Thêm duration cho chắc
        behavior: SnackBarBehavior.floating,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 1500));

    isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    Navigator.pushNamed(
      context,
      AppRouter.otp,
      arguments: {
        'phoneNumber': phoneNumber,
        'isRegister': true, // QUAN TRỌNG: Phải có cái này để hiện nút đỏ
      },
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
