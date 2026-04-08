import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:telecom_app/gen/assets.gen.dart';
import 'package:telecom_app/views/notifications/notification_model.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationModel item;

  const NotificationDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Phân biệt kiểu layout để chỉnh căn lề (TextAlign)
    final bool isGiftLayout = item.layoutType == NotificationLayoutType.gift;
    final TextAlign contentAlign = isGiftLayout
        ? TextAlign.center
        : TextAlign.left;
    final CrossAxisAlignment columnAlign = isGiftLayout
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: columnAlign, // Căn lề cụm giữa
          children: [
            const SizedBox(height: 10),

            // 2. Phần ảnh minh họa (ĐÃ SỬA DÙNG SVG)
            _buildSvgImage(item.layoutType),

            const SizedBox(height: 40),

            // 3. Tiêu đề
            Text(
              item.title,
              textAlign: contentAlign, // Căn lề chữ
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 20),

            // 4. Nội dung chi tiết
            Text(
              item.content,
              textAlign: contentAlign, // Căn lề chữ
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 14,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildSvgImage(NotificationLayoutType type) {
    // 1. Lấy đúng đường dẫn String từ Assets Gen bằng .path
    String imagePath = (type == NotificationLayoutType.gift)
        ? Assets.images.gift
        : Assets.images.notification;

    return Center(
      child: SvgPicture.asset(
        imagePath, // Giờ nó là String chuẩn rồi, không sai được
        width: 280,
        fit: BoxFit.contain,
        // Hiệu ứng load cho chuyên nghiệp
        placeholderBuilder: (context) => const SizedBox(
          height: 280,
          child: Center(child: CircularProgressIndicator(color: Colors.red)),
        ),
      ),
    );
  }
}
