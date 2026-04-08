import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telecom_app/navigation/app_router.dart';
import 'package:telecom_app/views/home/package_model.dart';
import 'package:telecom_app/gen/assets.gen.dart';
// (Nhớ import ExchangeProvider nếu ông có dùng để lấy điểm)

class SuccessPage extends StatelessWidget {
  // 1. CÁC BIẾN CŨ CỦA ÔNG
  final PackageModel package;
  final String packageName;
  final String transactionId;
  final bool isExchange;

  // 🎯 2. THÊM 2 BIẾN MỚI NÀY VÀO ĐỂ HỨNG DỮ LIỆU (ĐÂY CHÍNH LÀ BƯỚC 2)
  final bool isGift;
  final String? recipientPhone;

  // 🎯 3. KHAI BÁO VÀO CONSTRUCTOR (CÁI CỬA NHẬN HÀNG)
  const SuccessPage({
    super.key,
    required this.package,
    required this.packageName,
    required this.transactionId,
    this.isExchange = false,
    this.isGift = false, // Mặc định cho nó là false
    this.recipientPhone, // Cho phép rỗng (null) vì khi mua/đổi điểm thì không có SĐT nhận
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: SvgPicture.asset(
                  // 🎯 Hiển thị icon hộp quà nếu là TẶNG, ngược lại hiện icon thành công
                  isGift ? Assets.images.gift : Assets.images.amico,
                  width: 300,
                  height: 240,
                ),
              ),

              const SizedBox(height: 30),

              // 🎯 TIÊU ĐỀ THEO LUỒNG
              Text(
                isGift
                    ? "Tặng gói cước thành công"
                    : (isExchange
                          ? "Đổi điểm thành công"
                          : "Đăng ký thành công"),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 40),

              // 🎯 THÔNG TIN CHI TIẾT THEO LUỒNG
              if (isGift) ...[
                // --- GIAO DIỆN TẶNG QUÀ (Theo Figma) ---
                _buildRow("Gói cước", packageName, isBoldValue: true),
                const SizedBox(height: 16),
                _buildRow("Số tiền thanh toán", package.price),
                const SizedBox(height: 16),
                _buildRow(
                  "Số điện thoại nhận",
                  recipientPhone ?? "",
                ), // Hiện SĐT người nhận
              ] else if (isExchange) ...[
                // --- GIAO DIỆN ĐỔI ĐIỂM ---
                _buildRow("Gói cước", packageName, isBoldValue: true),
                const SizedBox(height: 16),
                _buildRow(
                  "Số điểm sử dụng",
                  "${package.price.replaceAll(RegExp(r'[^0-9]'), '')} điểm",
                ),
                const SizedBox(height: 16),
                // LƯU Ý: Nếu không dùng Provider cho điểm thì sửa lại dòng dưới nhé
                // _buildRow("Số điểm còn lại", "${context.watch<ExchangeProvider>().points} điểm"),
              ] else ...[
                // --- GIAO DIỆN MUA GÓI BẰNG TIỀN ---
                _buildRow("Gói cước", packageName, isBoldValue: true),
                const SizedBox(height: 16),
                _buildRow("Mệnh giá thanh toán", package.price),
                const SizedBox(height: 16),
                _buildRow("Hình thức", "Tài khoản chính"),
              ],

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: Color(0xFFEEEEEE), thickness: 1),
              ),

              // 🎯 THÔNG TIN CHUNG (Thời gian & Mã tham chiếu)
              _buildRow("Thời điểm giao dịch", "12:03 15 Th7, 2024"),
              const SizedBox(height: 16),
              _buildRow("Mã tham chiếu", transactionId),

              const Spacer(),

              // 🎯 NÚT TRỞ VỀ
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouter.home,
                    (route) => false,
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Trở về",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm _buildRow vẽ các dòng chữ (giữ nguyên của ông)
  Widget _buildRow(String label, String value, {bool isBoldValue = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
