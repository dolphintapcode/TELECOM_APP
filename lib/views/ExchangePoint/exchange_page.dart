import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:telecom_app/gen/assets.gen.dart';
import 'package:telecom_app/views/ExchangePoint/exchange_provider.dart';
import 'package:telecom_app/views/home/package_model.dart';
import 'package:telecom_app/views/home/package_provider.dart';
import 'package:telecom_app/views/widgets/package_card.dart';

class ExchangePage extends StatelessWidget {
  const ExchangePage({super.key});

  @override
  Widget build(BuildContext context) {
    final packageVM = context.watch<PackageProvider>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          // 1. Thẻ điểm User
          _buildCustomPointsCard(context),

          const SizedBox(height: 20),

          // 2. Gói theo ngày
          _buildSectionHeader('GÓI THEO NGÀY'),
          const SizedBox(height: 10),
          _buildPackageList(packageVM.dailyPackages),

          const SizedBox(height: 20),

          // 3. Gói theo tuần
          _buildSectionHeader('GÓI THEO TUẦN'),
          const SizedBox(height: 10),
          _buildPackageList(packageVM.weeklyPackages),

          const SizedBox(height: 20),

          // 4. Gói theo tháng
          _buildSectionHeader('GÓI THEO THÁNG'),
          const SizedBox(height: 10),
          _buildPackageList(packageVM.monthlyPackages),

          const SizedBox(height: 120),
        ],
      ),
    );
  }

  // --- THẺ ĐIỂM ---
  Widget _buildCustomPointsCard(BuildContext context) {
    final exchangeVM = context.watch<ExchangeProvider>();

    return Container(
      width: double.infinity,
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF4D0F0F), Color(0xFFEF3124)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: 0.15,
              child: SizedBox(
                width: 400,
                child: SvgPicture.asset(
                  Assets.icons.vector1,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Positioned(
            left: 266,
            top: 94,
            child: Image.asset(Assets.icons.sao.path, width: 54, height: 54),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exchangeVM.userName.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(),
                Text(
                  exchangeVM.formattedPoints,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "Số điểm hiện có",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.info_outline,
                      size: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- TIÊU ĐỀ MỤC ---
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const Icon(Icons.arrow_forward, color: Colors.red, size: 20),
        ],
      ),
    );
  }

  // --- DANH SÁCH GÓI ---
  Widget _buildPackageList(List<PackageModel> packages) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: packages.length,
        itemBuilder: (context, index) {
          return PackageCard(
            item: packages[index],
            isExchange:
                true, // Biến này để kích hoạt giao diện/chức năng đổi điểm
          );
        },
      ),
    );
  }
}
