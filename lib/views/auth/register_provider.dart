import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../navigation/app_router.dart';
// 🎯 Import AuthProvider của ông vào đây
import 'package:telecom_app/views/auth/auth_provider.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String? phoneErrorText;
  String? nameErrorText;
  bool isLoading = false;

  void onPhoneChanged(String value) {
    if (value.length >= 10 && phoneErrorText != null) {
      phoneErrorText = null;
      notifyListeners();
    }
  }

  void onNameChanged(String value) {
    if (value.isNotEmpty && nameErrorText != null) {
      nameErrorText = null;
      notifyListeners();
    }
  }

  Future<void> handleRegister(BuildContext context) async {
    String phoneNumber = phoneController.text.trim();
    String name = nameController.text.trim();

    phoneErrorText = null;
    nameErrorText = null;

    if (phoneNumber.length < 10 || name.isEmpty) {
      if (phoneNumber.length < 10) {
        phoneErrorText = 'Số điện thoại phải có ít nhất 10 số';
      }
      if (name.isEmpty) nameErrorText = 'Vui lòng nhập tên của bạn';
      notifyListeners();
      return;
    }

    // 🎯 BẮT ĐẦU CHECK FIREBASE
    isLoading = true;
    notifyListeners();
    FocusScope.of(context).unfocus();

    final authProvider = context.read<AuthProvider>();

    // 1. Kiểm tra xem số này đã có người đăng ký chưa
    bool isExist = await authProvider.checkPhoneExists(phoneNumber);

    isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    if (isExist) {
      // Nếu đã tồn tại thì không cho đăng ký nữa
      phoneErrorText = 'Số điện thoại này đã được đăng ký rồi!';
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SĐT đã tồn tại, vui lòng đăng nhập!'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // 2. Nếu chưa tồn tại -> Cho sang màn OTP
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang gửi mã xác thực tới $phoneNumber...'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // 🎯 TRUYỀN DỮ LIỆU SANG OTP
    Navigator.pushNamed(
      context,
      AppRouter.otp,
      arguments: {
        'phoneNumber': phoneNumber,
        'displayName': name, // 🎯 Gửi kèm tên để tí nữa lưu DB
        'isRegister': true,
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
