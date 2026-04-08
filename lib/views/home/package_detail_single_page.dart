import 'package:flutter/material.dart';
import 'package:telecom_app/views/home/package_model.dart';

import 'package:telecom_app/views/home/success_page.dart';

class PackageDetailSinglePage extends StatelessWidget {
  final PackageModel package;

  const PackageDetailSinglePage({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    final app = package.apps.isNotEmpty ? package.apps.first : null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Chi tiết gói cước",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: package.image.image(fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoRow("Hạn sử dụng", "1 ngày"),
                  const Divider(height: 1, color: Color(0xFFF5F5F5)),
                  _buildInfoRow(
                    "Số tiền thanh toán",
                    package.price,
                    isRed: true,
                  ),
                  const Divider(height: 1, color: Color(0xFFF5F5F5)),
                  _buildInfoRow("Cú pháp đăng ký", "ON12 gửi 5282"),
                  const Divider(height: 1, color: Color(0xFFF5F5F5)),
                  const SizedBox(height: 30),
                  const Text(
                    "ỨNG DỤNG ÁP DỤNG GÓI",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  if (app != null)
                    _buildAppItem(app)
                  else
                    const Text("Đang cập nhật ứng dụng..."),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(
        context,
      ), // Truyền context vào đây
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isRed ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppItem(AppItemModel app) {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: app.icon.image(fit: BoxFit.cover),
            ),
          ),
          title: Text(
            app.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          subtitle: Text(
            app.developer,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
        ),
        const Divider(height: 1, color: Color(0xFFF5F5F5)),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    // Thêm context ở đây
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF5F5F5))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              // Bỏ const ở Row
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // Thêm const vào list children
                Icon(Icons.card_giftcard, color: Colors.red, size: 18),
                SizedBox(width: 8),
                Text(
                  "Tặng cho bạn bè",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Gọi Dialog xác nhận
              PackageDialog.showConfirmDialog(context, package);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Đăng ký",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRemainingTime() {
  return Container(
    padding: EdgeInsets.all(16),
    color: Colors.red.shade50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Thời gian còn lại", style: TextStyle(color: Colors.red)),
        Text(
          "3 ngày 12 giờ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ],
    ),
  );
}
