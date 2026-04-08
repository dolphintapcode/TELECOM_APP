import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telecom_app/core/themes/app_colors.dart';
import 'package:telecom_app/gen/assets.gen.dart';
import 'splash_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Gọi logic chuyển trang từ ViewModel
    // Dùng microtask hoặc addPostFrameCallback để đảm bảo context đã sẵn sàng
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashProvider>().initSplash(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Hình trang trí lưới xanh nằm sát đáy màn hình
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(Assets.icons.vector, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
