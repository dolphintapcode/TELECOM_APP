import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telecom_app/core/themes/app_colors.dart';
import 'package:telecom_app/gen/assets.gen.dart';
import '../../widgets/custom_button.dart';
// 1. Phải import file AppRouter vào đây
import '../../../navigation/app_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            // 1. Dùng Opacity để làm mờ ảnh nền
            child: Opacity(
              opacity:
                  1.0, // Giá trị từ 0.0 (trong suốt hoàn toàn) đến 1.0 (hiện rõ hoàn toàn). 0.3 là mờ 30%.
              child: SvgPicture.asset(
                Assets.icons.vector,
                fit: BoxFit.cover, // Căn chỉnh cho hình tràn viền ngang
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 40.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    Image.asset(Assets.icons.dataonLogo.path, height: 80),

                    const SizedBox(height: 60),

                    // 2. Phần Text Chào mừng (Dùng RichText để tô màu từng đoạn)
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          height: 1.3,
                        ),
                        children: [
                          TextSpan(text: 'Chào mừng bạn\nđến với '),
                          TextSpan(
                            text: 'DataOn',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 3. Slogan
                    const Text(
                      'Data di động không giới hạn.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 220),
                    // Nút Đăng nhập (Màu xám đậm)
                    CustomButton(
                      text: 'Đăng nhập',
                      backgroundColor: const Color(
                        0xFF424242,
                      ), // Màu xám đậm theo hình
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRouter.login),
                    ),
                    const SizedBox(height: 16),

                    // Nút Đăng ký (Màu Đỏ mặc định)
                    // Trong welcome_page.dart
                    CustomButton(
                      text: 'Đăng ký tài khoản',
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRouter.register),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
