import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telecom_app/views/notifications/notification_detail.dart';
import 'package:telecom_app/views/notifications/notification_model.dart';
import 'notification_provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isSystemTab = false; // false: Khuyến mại, true: Thông báo

  // --- HÀM XÁC NHẬN XÓA (Đã nhấc ra ngoài cho đúng cú pháp) ---
  void _showDeleteConfirm(
    BuildContext context,
    NotificationProvider vm,
    bool isSystem,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Xác nhận xóa"),
        content: Text(
          "Bạn muốn xóa tất cả thông báo ${isSystem ? 'Hệ thống' : 'Khuyến mại'}?",
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Hủy", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              vm.clearByTab(isSystem); // Gọi hàm xóa riêng biệt
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Đã xóa thông báo"),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: const Text(
              "Xóa",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notiVM = context.watch<NotificationProvider>();
    // Lấy list theo tab hiện tại từ Provider
    final listShow = notiVM.getByType(isSystemTab);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Thông báo",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black),
            onPressed: () {
              // Bấm vào đây là hiện xác nhận xóa cho Tab đang đứng
              _showDeleteConfirm(context, notiVM, isSystemTab);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Thanh chuyển Tab
          _NotificationTabToggle(
            isSystemTab: isSystemTab,
            onChanged: (val) => setState(() => isSystemTab = val),
          ),

          Expanded(
            child: listShow.isEmpty
                ? const Center(
                    child: Text(
                      "Không có thông báo nào",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: listShow.length,
                    separatorBuilder: (_, _) => const Divider(
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Color(0xFFEEEEEE),
                    ),
                    itemBuilder: (context, index) =>
                        _NotificationItem(item: listShow[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

// --- ITEM THÔNG BÁO ---
// --- ITEM THÔNG BÁO ---
class _NotificationItem extends StatelessWidget {
  final NotificationModel item;
  const _NotificationItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              item.time,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            item.content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
        ),
        // --- CHỖ SỬA ĐÂY NÈ TRUNG ---
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationDetailPage(item: item),
            ),
          );
        },
      ),
    );
  }
}

// --- TOGGLE TAB ---
class _NotificationTabToggle extends StatelessWidget {
  final bool isSystemTab;
  final ValueChanged<bool> onChanged;
  const _NotificationTabToggle({
    required this.isSystemTab,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          _buildBtn("Khuyến mại", !isSystemTab, () => onChanged(false)),
          _buildBtn("Thông báo", isSystemTab, () => onChanged(true)),
        ],
      ),
    );
  }

  Widget _buildBtn(String text, bool isActive, VoidCallback onTap) {
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
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
