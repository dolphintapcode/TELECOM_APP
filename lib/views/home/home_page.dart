import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telecom_app/views/ExchangePoint/exchange_page.dart';
import 'package:telecom_app/views/home/buy_package_page.dart';
import 'package:telecom_app/views/home/home_banner.dart';
import 'package:telecom_app/views/home/package_model.dart';
import 'package:telecom_app/views/home/package_provider.dart';
import 'package:telecom_app/views/notifications/notification_page.dart';
import 'package:telecom_app/views/widgets/package_card.dart';
import 'package:telecom_app/views/history/history_page.dart';
import 'home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy dữ liệu từ Provider
    final packageVM = context.watch<PackageProvider>();
    final homeVM = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F6),
      // 1. AppBar: Truyền context vào hàm con để xử lý Navigator
      appBar: homeVM.selectedIndex == 0 ? _buildAppBar(context) : null,

      // 2. Body: Dùng IndexedStack để giữ trạng thái các màn hình khi chuyển Tab
      body: IndexedStack(
        index: homeVM.selectedIndex,
        children: [
          _buildHomeContent(context, packageVM), // Index 0: Trang chủ
          const HistoryPage(), // Index 1: Lịch sử
          const ExchangePage(), // Index 2
          const Center(child: Text("Menu")), // Index 3
        ],
      ),

      // 3. Bottom Navigation Bar dạng Floating
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingBottomNav(homeVM),
    );
  }

  // --- HÀM XÂY DỰNG APPBAR (Đã fix lỗi context) ---
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFFF5F5F6),
      elevation: 0,

      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none,
            color: Colors.black,
            size: 28,
          ),
          onPressed: () {
            // Navigator cần context để biết đang ở đâu trong App
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationPage()),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // --- NỘI DUNG TRANG CHỦ ---
  Widget _buildHomeContent(BuildContext context, PackageProvider packageVM) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const HomeBanner(),
          const SizedBox(height: 40),

          // Gói theo ngày
          _buildSectionHeader(
            context,
            'GÓI THEO NGÀY',
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const BuyPackagePage(),
              );
            },
          ),
          const SizedBox(height: 10),
          _buildPackageList(packageVM.dailyPackages),

          // Gói theo tuần
          const SizedBox(height: 20),
          _buildSectionHeader(context, 'GÓI THEO TUẦN'),
          const SizedBox(height: 10),
          _buildPackageList(packageVM.weeklyPackages),

          // Gói theo tháng
          const SizedBox(height: 20),
          _buildSectionHeader(context, 'GÓI THEO THÁNG'),
          const SizedBox(height: 10),
          _buildPackageList(packageVM.monthlyPackages),

          const SizedBox(height: 120), // Tránh đè nút Nav
        ],
      ),
    );
  }

  // --- DANH SÁCH GÓI CƯỚC (NẰM NGANG) ---
  Widget _buildPackageList(List<PackageModel> packages) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: packages.length,
        itemBuilder: (context, index) {
          return PackageCard(item: packages[index]);
        },
      ),
    );
  }

  // --- TIÊU ĐỀ CÁC MỤC ---
  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_forward_ios, color: Colors.red, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  // --- FLOATING BOTTOM NAV BAR ---
  Widget _buildFloatingBottomNav(HomeProvider vm) {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(vm, Icons.home_filled, 'Trang chủ', 0),
          _buildNavItem(vm, Icons.chat_bubble, 'Lịch sử', 1),
          _buildNavItem(vm, Icons.auto_awesome_outlined, 'Đổi điểm', 2),
          _buildNavItem(vm, Icons.menu, 'Mở rộng', 3),
        ],
      ),
    );
  }

  // --- ITEM TRONG NAV BAR ---
  Widget _buildNavItem(
    HomeProvider vm,
    IconData icon,
    String label,
    int index,
  ) {
    bool isSelected = vm.selectedIndex == index;
    return GestureDetector(
      onTap: () => vm.setSelectedIndex(index),
      behavior: HitTestBehavior.opaque, // Tăng vùng nhận diện chạm
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.red : Colors.grey, size: 28),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
