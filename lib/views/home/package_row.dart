import 'package:flutter/material.dart';
import 'package:telecom_app/views/home/package_model.dart';
import 'package:telecom_app/views/home/success_page.dart';

class PackageRow extends StatelessWidget {
  final PackageModel item;
  final VoidCallback? onTap;

  const PackageRow({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ), // Chỉnh lại padding cho cân đối
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Icon Grid bên trái
          _buildIconGrid(item),

          const SizedBox(width: 15),

          // 2. Nội dung text - Dùng Expanded bao toàn bộ cụm giữa
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HÀNG TIÊU ĐỀ + GIÁ
                Row(
                  children: [
                    // 🔥 FIX LỖI Ở ĐÂY: Bọc tiêu đề vào Expanded để không đẩy giá ra ngoài
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // Giảm 1 size để đỡ chiếm chỗ
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Badge Giá tiền màu đỏ
                    _buildPriceBadge(item.price),
                  ],
                ),
                const SizedBox(height: 4),

                // Dòng mô tả: Dùng RichText khống chế 1 dòng
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    children: [
                      TextSpan(
                        text: item
                            .duration, // Lấy động từ model thay vì fix cứng "1 ngày"
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: "  •  ${item.description}"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // 3. Nút Đăng ký
          _buildRegisterButton(context),
        ],
      ),
    );
  }

  // --- WIDGET CON TÁCH RA CHO SẠCH CODE ---

  Widget _buildIconGrid(PackageModel item) {
    return Container(
      width: 56, // Size vừa đủ để không bị to quá
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: item.image.image(fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildPriceBadge(String price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        price,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () => PackageDialog.showConfirmDialog(context, item),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minimumSize: const Size(70, 30),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      child: const Text(
        "Đăng ký",
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
