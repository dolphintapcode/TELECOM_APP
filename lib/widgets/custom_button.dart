import 'package:flutter/material.dart';
import 'package:telecom_app/core/themes/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor; // Thêm biến màu nền tùy chỉnh

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor, // Không bắt buộc truyền
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // Nếu có truyền màu thì dùng màu đó, không thì dùng màu Đỏ mặc định
          backgroundColor: backgroundColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0, // Bỏ đổ bóng cho giống thiết kế phẳng
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
