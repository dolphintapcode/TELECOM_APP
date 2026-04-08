import 'package:flutter/material.dart';
import 'package:telecom_app/core/utils/dialog_utils.dart';
import 'package:telecom_app/navigation/app_router.dart';
import 'package:telecom_app/views/home/package_model.dart';

class PackageDetailMultiPage extends StatelessWidget {
  final PackageModel package;
  final bool isHistory;
  final bool isExpired;
  final bool isExchange;
  final bool isGift;

  const PackageDetailMultiPage({
    super.key,
    required this.package,
    this.isHistory = false,
    this.isExpired = false,
    this.isExchange = false,
    this.isGift = false,
  });

  @override
  Widget build(BuildContext context) {
    print(
      "Check: History=$isHistory, Expired=$isExpired, Exchange=$isExchange",
    );
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

            if (isHistory)
              _RemainingTimeBox(
                duration: package.duration,
                isExpired: isExpired,
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

                  _InfoRow(label: "Hạn sử dụng", value: package.duration),
                  const Divider(height: 1, color: Color(0xFFF5F5F5)),

                  // 🎯 ĐỔI TÊN LABEL VÀ ĐƠN VỊ TIỀN -> ĐIỂM DỰA VÀO CỜ isExchange
                  _InfoRow(
                    label: isExchange
                        ? "Số điểm quy đổi"
                        : "Số tiền thanh toán",
                    // 🔥 DÙNG replaceAll('đ', '') ĐỂ XÓA CHỮ "đ" TRƯỚC KHI THÊM CHỮ " điểm"
                    value: isExchange
                        ? "${package.price.replaceAll('đ', '')} điểm"
                        : package.price,
                    isRed: true,
                  ),

                  const Divider(height: 1, color: Color(0xFFF5F5F5)),
                  const _InfoRow(
                    label: "Cú pháp đăng ký",
                    value: "ON12 gửi 5282",
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    "ỨNG DỤNG ÁP DỤNG GÓI",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 10),

                  ...package.apps.map((app) => _AppItem(app: app)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomAction(
        package: package,
        isHistory: isHistory,
        isExpired: isExpired,
        isExchange: isExchange,
      ),
    );
  }
}

// =====================================================================
// CÁC PRIVATE CLASS TÁCH RA TỪ HÀM
// =====================================================================

class _RemainingTimeBox extends StatelessWidget {
  final String duration;
  final bool isExpired;
  const _RemainingTimeBox({required this.duration, required this.isExpired});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.access_time_filled, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text(
                "Thời hạn còn lại",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            isExpired ? "Đã hết hạn" : duration,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.red,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isRed;

  const _InfoRow({
    required this.label,
    required this.value,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
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
}

class _AppItem extends StatelessWidget {
  final AppItemModel app;
  const _AppItem({required this.app});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: app.icon.image(width: 44, height: 44, fit: BoxFit.cover),
          ),
          title: Text(
            app.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          subtitle: Text(
            app.developer,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        const Divider(height: 1, color: Color(0xFFF5F5F5)),
      ],
    );
  }
}

class _BottomAction extends StatelessWidget {
  final PackageModel package;
  final bool isHistory;
  final bool isExpired;
  final bool isExchange;

  const _BottomAction({
    required this.package,
    required this.isHistory,
    required this.isExpired,
    this.isExchange = false,
  });

  @override
  Widget build(BuildContext context) {
    // 🎯 BƯỚC 1: XÁC ĐỊNH TRẠNG THÁI GÓI
    // Gói được coi là "Đã sở hữu" nếu nó nằm trong Lịch sử và chưa hết hạn
    bool isOwned = isHistory && !isExpired;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF5F5F5))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. NÚT TẶNG CHO BẠN BÈ
          // (Luôn hiện ở màn Mua bằng tiền, kể cả khi đã mua rồi vẫn cho tặng bạn bè)
          if (!isExchange) ...[
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.giftPackage, // Dùng route ông vừa đăng ký
                  arguments: {'package': package},
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Tặng cho bạn bè",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],

          // 2. NÚT CHÍNH: Đổi điểm / Đăng ký / Trạng thái đã sở hữu
          ElevatedButton(
            // 🎯 BƯỚC 2: KHÓA BẤM NẾU ĐÃ SỞ HỮU (onPressed = null sẽ làm nút xám đi)
            onPressed: isOwned
                ? null
                : () {
                    if (isExchange) {
                      // 🎯 GỌI HÀM DÙNG CHUNG (Đổi điểm)
                      DialogUtils.showPackageConfirmDialog(
                        context,
                        package: package,
                        type: TransactionType.exchange,
                      );
                    } else {
                      // 🎯 GỌI HÀM DÙNG CHUNG (Mua bằng tiền)
                      DialogUtils.showPackageConfirmDialog(
                        context,
                        package: package,
                        type: TransactionType.buy,
                      );
                    }
                  },
            style: ElevatedButton.styleFrom(
              // Nếu đã sở hữu thì cho màu xám, ngược lại màu đỏ
              backgroundColor: isOwned ? Colors.grey.shade300 : Colors.red,
              foregroundColor: isOwned ? Colors.grey.shade600 : Colors.white,
              disabledBackgroundColor:
                  Colors.grey.shade300, // Màu khi nút bị khóa
              disabledForegroundColor: Colors.grey.shade600,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: isOwned ? 0 : 2,
            ),
            child: Text(
              // 🎯 BƯỚC 3: ĐỔI CHỮ THEO ĐÚNG LOGIC TRUNG YÊU CẦU
              isOwned
                  ? (isExchange
                        ? "Đã đổi thưởng"
                        : "Đã đăng ký") // Nếu đang dùng
                  : (isExchange
                        ? "Đổi điểm thưởng"
                        : (isHistory
                              ? "Đăng ký lại"
                              : "Đăng ký")), // Nếu chưa mua/hết hạn
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
