import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 🎯 IMPORT PROVIDER
import 'package:telecom_app/navigation/app_router.dart';
import 'package:telecom_app/views/home/package_model.dart';
import 'package:telecom_app/views/history/history_provider.dart'; // 🎯 IMPORT HISTORY PROVIDER

class PackageCard extends StatefulWidget {
  final PackageModel item;
  final bool isExchange; // Biến cờ phân biệt 2 màn hình
  const PackageCard({super.key, required this.item, this.isExchange = false});

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  // Biến state để biết chuột có đang hover qua card không
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // 🎯 1. KIỂM TRA TRẠNG THÁI SỞ HỮU GÓI CƯỚC TỪ PROVIDER
    final historyVM = context.watch<HistoryProvider>();

    // 🔥 LƯU Ý: Thay chữ 'packages' thành tên danh sách thực tế trong HistoryProvider của ông
    bool isOwned = false;
    try {
      isOwned = historyVM.activePackages.any(
        (p) => p.title == widget.item.title,
      );
    } catch (e) {
      print("Lỗi check gói: $e");
    }

    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 17, bottom: 10, top: 5),
      // Dùng AnimatedContainer để hiệu ứng bóng đổ mượt mà khi đổi state
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Thời gian loang bóng
        curve: Curves.easeInOut, // Hiệu ứng mượt
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          // --- LOGIC BÓNG ĐỔ ĐỘNG Ở ĐÂY ---
          boxShadow: [
            _isHovered
                // 1. Khi Hover: Bóng đậm hơn (Opacity 0.08), loang rộng hơn (blur 20)
                ? BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10), // Đẩy bóng xuống thấp hơn
                  )
                // 2. Khi bình thường: Bóng siêu mờ (Opacity 0.04)
                : BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
          ],
        ),
        // --- DÙNG INKWELL ĐỂ BẮT SỰ KIỆN HOVER ---
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.packageDetail,
              arguments: {
                // 🎯 PHẢI TRUYỀN DƯỚI DẠNG MAP NHƯ THẾ NÀY
                'package': widget.item,
                'isExchange': widget.isExchange, // Cờ này cực quan trọng!
                'isHistory':
                    isOwned, // 🔥 Truyền luôn trạng thái đã sở hữu sang màn Detail
                'isExpired': false,
              },
            );
          },
          // 4. CẬP NHẬT STATE KHI DI CHUỘT VÀO/RA
          onHover: (hovering) {
            setState(() {
              _isHovered = hovering;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Phần ảnh gói cước
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: AspectRatio(
                  aspectRatio: 170 / 130,
                  child: widget.item.image.image(fit: BoxFit.cover),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Tên gói và Giá/Điểm
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // 🔥 TRUYỀN isExchange VÀO ĐỂ ĐỔI GIAO DIỆN GIÁ/ĐIỂM
                        _PriceBadge(
                          price: widget.item.price,
                          isExchange: widget.isExchange,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // 3. Mô tả và Nút Đăng ký/Đổi thưởng
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.item.description,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // 🎯 2. TRUYỀN THÊM BIẾN isOwned XUỐNG NÚT BẤM
                        _ActionButton(
                          isExchange: widget.isExchange,
                          isOwned: isOwned, // 🔥 Thêm dòng này
                          // Nếu đã sở hữu thì khóa nút bấm (tránh mua trùng)
                          onPressed: isOwned
                              ? null
                              : () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouter.packageDetail,
                                    arguments: {
                                      'package': widget.item,
                                      'isExchange': widget.isExchange,
                                      'isHistory': false,
                                      'isExpired': false,
                                    },
                                  );
                                },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- PRIVATE WIDGET: Ô GIÁ HOẶC ĐIỂM ---
class _PriceBadge extends StatelessWidget {
  final String price;
  final bool isExchange;
  const _PriceBadge({required this.price, required this.isExchange});

  @override
  Widget build(BuildContext context) {
    final String displayValue = isExchange
        ? "${price.replaceAll('đ', '')} điểm"
        : price;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isExchange ? Colors.transparent : Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        displayValue,
        style: TextStyle(
          color: isExchange ? Colors.grey : Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// --- PRIVATE WIDGET: NÚT ĐĂNG KÝ HOẶC ĐỔI THƯỞNG ---
class _ActionButton extends StatelessWidget {
  final bool isExchange;
  final bool isOwned; // 🎯 KHAI BÁO BIẾN MỚI
  final VoidCallback? onPressed; // 🎯 CHO PHÉP NULL ĐỂ KHÓA NÚT

  const _ActionButton({
    required this.isExchange,
    required this.isOwned,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // 🎯 TRƯỜNG HỢP 1: NẾU ĐÃ SỞ HỮU RỒI -> HIỆN NÚT XÁM KHÓA LẠI
    if (isOwned) {
      return SizedBox(
        height: 28,
        child: OutlinedButton(
          onPressed: null, // Khóa nút
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey.shade400),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            isExchange ? 'Đã đổi thưởng' : 'Đã đăng ký',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    // 🎯 TRƯỜNG HỢP 2: CHƯA SỞ HỮU + ĐANG Ở MÀN ĐỔI ĐIỂM
    if (isExchange) {
      return SizedBox(
        height: 28,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Đổi điểm thưởng',
            style: TextStyle(
              color: Colors.red,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    // 🎯 TRƯỜNG HỢP 3: CHƯA SỞ HỮU + ĐANG Ở MÀN MUA BẰNG TIỀN (Mặc định)
    return SizedBox(
      height: 28,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered)) {
              return Colors.red.shade100;
            }
            return Colors.red.shade50;
          }),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
        child: const Text(
          'Đăng ký',
          style: TextStyle(
            color: Colors.red,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
