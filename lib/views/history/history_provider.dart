import 'package:flutter/material.dart';
import 'package:telecom_app/gen/assets.gen.dart';
import 'package:telecom_app/views/home/package_model.dart';

class HistoryProvider extends ChangeNotifier {
  final List<PackageModel> _activePackages = [];
  final List<PackageModel> _expiredPackages = [
    PackageModel(
      title: 'Gói tuần tổng hợp DataON',
      price: '10.000đ',
      image: Assets.images.home, // Nhớ import Assets của Trung
      duration: '7 ngày',
      description: 'Zalo, Instagram, Drive, Gmail...',
      apps: [
        AppItemModel(
          name: "Zalo",
          developer: "Zalo Group",
          icon: Assets.icons.zalo,
        ),
      ], // Để trống cũng được để test
      isExpired: true, // <--- ĐÁNH DẤU LÀ HẾT HẠN
    ),
  ];

  List<PackageModel> get activePackages => _activePackages;
  List<PackageModel> get expiredPackages => _expiredPackages;

  // Hàm thêm gói mới khi bấm đăng ký hoặc đăng ký lại gói đã hết hạn
  void addPackageToHistory(PackageModel package) {
    // Nếu gói đã có trong danh sách hết hạn, loại bỏ nó trước
    _expiredPackages.removeWhere((item) => item.title == package.title);

    // Nếu gói đang dùng đã tồn tại, cập nhật lại vị trí lên đầu
    _activePackages.removeWhere((item) => item.title == package.title);

    _activePackages.insert(
      0,
      PackageModel(
        title: package.title,
        price: package.price,
        image: package.image,
        description: package.description,
        duration: package.duration,
        apps: package.apps,
      ),
    );
    notifyListeners();
  }
}
