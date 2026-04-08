import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telecom_app/views/history/history_provider.dart';
import 'package:telecom_app/views/home/package_model.dart';

class PackageDialog {
  static void showConfirmDialog(BuildContext context, PackageModel package) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Xác nhận mua gói",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Quý khách xác nhận đăng ký gói cước sau qua tài khoản chính điện thoại?",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            Text("Gói", style: TextStyle(fontSize: 12, color: Colors.grey)),
            Text(
              package.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),
            const Text(
              "Thời gian sử dụng",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Text("1 ngày", style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 15),
            const Text(
              "Số tiền thanh toán",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              package.price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Hủy"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<HistoryProvider>().addPackageToHistory(
                        package,
                      );
                      Navigator.pop(context); // Đóng cái Dialog lại trước

                      // CHUYỂN SANG MÀN THÀNH CÔNG VÀ TRUYỀN DATA
                      Navigator.pushNamed(
                        context,
                        '/success', // Tên route Trung vừa đặt ở trên
                        arguments: package,
                      ); // Tạm thời về Home hoặc trang Success nếu Trung đã làm router
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Xác nhận"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
