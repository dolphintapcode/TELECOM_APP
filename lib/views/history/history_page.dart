import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telecom_app/views/history/history_provider.dart';
import 'package:telecom_app/views/home/package_model.dart';
import 'package:telecom_app/navigation/app_router.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Biến state quản lý tab hiện tại
  bool isExpiredTab = false;

  @override
  Widget build(BuildContext context) {
    final historyVM = context.watch<HistoryProvider>();
    final listShow = isExpiredTab
        ? historyVM.expiredPackages
        : historyVM.activePackages;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF5F5F6),
        elevation: 0,
        title: const Text(
          "Lịch sử gói cước",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Dùng Private Class cho thanh Toggle, truyền state và hàm update State vào
          _TabToggle(
            isExpiredTab: isExpiredTab,
            onChanged: (bool isExpired) {
              setState(() {
                isExpiredTab = isExpired;
              });
            },
          ),

          Expanded(
            child: listShow.isEmpty
                ? const Center(
                    child: Text(
                      "Chưa có lịch sử đăng ký",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: listShow.length,
                    itemBuilder: (context, index) {
                      // Dùng Private Class cho Card
                      return _HistoryCard(
                        item: listShow[index],
                        isExpired: isExpiredTab,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// CÁC PRIVATE CLASS TÁCH RA TỪ HÀM (TỐI ƯU HIỆU SUẤT)
// =====================================================================

class _HistoryCard extends StatelessWidget {
  final PackageModel item;
  final bool isExpired;

  const _HistoryCard({required this.item, required this.isExpired});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.packageDetail,
          arguments: {
            'package': item,
            'isHistory': true,
            'isExpired': isExpired,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: item.image.image(width: 55, height: 55, fit: BoxFit.cover),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Gọi Private Class cho Badge
            _StatusBadge(
              isExpired: isExpired,
              duration: item.duration, // Lấy thời gian thực từ Model!
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isExpired;
  final String duration;

  const _StatusBadge({required this.isExpired, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isExpired ? Colors.grey.shade100 : const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time_outlined,
            size: 14,
            color: isExpired ? Colors.grey : Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            isExpired
                ? "Đã hết hạn"
                : "Còn $duration", // Chữ linh hoạt theo data
            style: TextStyle(
              color: isExpired ? Colors.grey : Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabToggle extends StatelessWidget {
  final bool isExpiredTab;
  final ValueChanged<bool> onChanged;

  const _TabToggle({required this.isExpiredTab, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 45,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E7),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _TabItem(
            title: "Gói cước đang dùng",
            isActive: !isExpiredTab,
            onTap: () => onChanged(false),
          ),
          _TabItem(
            title: "Đã hết hạn",
            isActive: isExpiredTab,
            onTap: () => onChanged(true),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.red : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
