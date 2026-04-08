import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telecom_app/navigation/app_router.dart';
import 'package:telecom_app/views/ExchangePoint/exchange_provider.dart';
import 'package:telecom_app/views/history/history_provider.dart';
import 'package:telecom_app/views/home/package_model.dart';

// 🎯 1. ĐỊNH NGHĨA 3 LOẠI GIAO DỊCH
enum TransactionType { buy, exchange, gift }

class DialogUtils {
  // 🎯 2. HÀM GỌI DIALOG DÙNG CHUNG
  static void showPackageConfirmDialog(
    BuildContext context, {
    required PackageModel package,
    required TransactionType type,
    String? recipientPhone, // Chỉ dùng khi là Tặng quà
  }) {
    // --- Xử lý biến đổi Text theo loại giao dịch ---
    String title = "";
    String subtitle = "";
    String confirmText = "Xác nhận";

    if (type == TransactionType.buy) {
      title = "Xác nhận mua gói";
      subtitle =
          "Quý khách xác nhận đăng ký gói cước sau qua tài khoản chính điện thoại?";
    } else if (type == TransactionType.exchange) {
      title = "Xác nhận đổi điểm";
      subtitle =
          "Quý khách xác nhận đăng ký gói cước sau qua hình thức đổi điểm?";
    } else if (type == TransactionType.gift) {
      title = "Xác nhận tặng gói cước";
      subtitle =
          "Quý khách xác nhận tặng gói cước cho thuê bao dưới đây. Dịch vụ chỉ áp dụng cho người nhận là thuê bao mạng Viettel.";
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        // 🎯 ÉP NỀN TRẮNG TINH (Xóa cái nền ám hồng của Material 3)
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // --- CÁC DÒNG THÔNG TIN (Hiển thị dọc theo mẫu mới) ---
            _infoColumnRow("Gói cước", package.title),
            _infoColumnRow("Thời gian sử dụng", package.duration),

            if (type == TransactionType.exchange)
              _infoColumnRow(
                "Số điểm quy đổi",
                "${package.price} điểm",
                isRed: true,
              )
            else
              _infoColumnRow("Số tiền thanh toán", package.price, isRed: true),

            if (type == TransactionType.gift)
              _infoColumnRow("Thuê bao nhận", recipientPhone ?? ""),

            const SizedBox(height: 30),

            // --- 2 NÚT BẤM DƯỚI CÙNG (Nút Hủy nền xám, Nút Xác nhận nền đỏ) ---
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(
                          0xFFF5F5F5,
                        ), // Nền xám nhạt
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text(
                        "Hủy",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEE4D2D), // Nền đỏ/cam
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        _handleConfirm(
                          context,
                          ctx,
                          package,
                          type,
                          recipientPhone,
                        );
                      },
                      child: Text(
                        confirmText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🎯 3. XỬ LÝ LOGIC KHI BẤM NÚT XÁC NHẬN
  static void _handleConfirm(
    BuildContext context,
    BuildContext dialogCtx,
    PackageModel package,
    TransactionType type,
    String? recipientPhone,
  ) {
    bool isSuccess = true;

    // A. Nếu là Đổi điểm -> Call hàm trừ điểm trước
    if (type == TransactionType.exchange) {
      final pointsNeeded =
          int.tryParse(package.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      final exchangeVM = context.read<ExchangeProvider>();
      isSuccess = exchangeVM.exchangePackage(pointsNeeded);

      if (!isSuccess) {
        Navigator.pop(dialogCtx);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Rất tiếc, bạn không đủ điểm!"),
            backgroundColor: Colors.red,
          ),
        );
        return; // Dừng lại không đi tiếp
      }
    }

    // B. Nếu thành công (hoặc là Mua/Tặng) -> Thêm vào kho lịch sử
    if (isSuccess) {
      // Tặng bạn bè thì không lưu vào kho Lịch sử (Kho "Đang dùng") của mình
      if (type != TransactionType.gift) {
        context.read<HistoryProvider>().addPackageToHistory(package);
      }

      Navigator.pop(dialogCtx); // Đóng popup

      // C. Chuyển sang màn Success với cờ tương ứng
      Navigator.pushNamed(
        context,
        AppRouter.success,
        arguments: {
          'package': package,
          'packageName': package.title,
          'transactionId':
              "${type.name.toUpperCase()}${DateTime.now().millisecondsSinceEpoch}",
          'isExchange': type == TransactionType.exchange,
          'isGift': type == TransactionType.gift,
          'recipientPhone': recipientPhone,
        },
      );
    }
  }

  // 🎯 HÀM VẼ GIAO DIỆN CHỮ DỌC (Nhãn ở trên xám nhỏ, Giá trị ở dưới đen đậm)
  static Widget _infoColumnRow(
    String label,
    String value, {
    bool isRed = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isRed ? Colors.red : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
