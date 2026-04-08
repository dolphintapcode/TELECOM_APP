import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart'; // Nhớ sửa lại đường dẫn theo cấu trúc core/ mới

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Để Nullable để có thể disable nút
  final Color? backgroundColor;
  final bool isLoading; // Thêm trạng thái loading ngay trên nút
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.isLoading = false, // Mặc định là không loading
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52, // Tăng nhẹ chiều cao cho sang trọng hơn
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // Nếu onPressed là null (disable) thì Flutter tự đổi sang màu xám nhạt
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        // Nếu đang loading thì khóa nút (onPressed = null)
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
