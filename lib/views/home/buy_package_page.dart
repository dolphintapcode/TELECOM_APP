import 'package:flutter/material.dart';
import 'package:telecom_app/views/home/home_banner.dart';
import 'package:telecom_app/views/home/package_provider.dart';
import 'package:telecom_app/views/home/package_row.dart';
import 'package:provider/provider.dart';

class BuyPackagePage extends StatelessWidget {
  const BuyPackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final packageVM = context.watch<PackageProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          // 1. Banner Slider ở trên
          const HomeBanner(),

          // 2. Danh sách gói (Phần màu trắng bo góc)
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thanh ngang nhỏ ở trên đầu cho giống BottomSheet
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "GÓI THEO NGÀY",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // List các gói cước
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: packageVM.dailyPackages.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, color: Color(0xFFF5F5F5)),
                      itemBuilder: (context, index) {
                        return PackageRow(
                          item: packageVM.dailyPackages[index],
                          onTap: () {
                            // Điều hướng sang trang chi tiết
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
