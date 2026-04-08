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

  // Hàm thêm gói mới khi bấm đăng ký
  void addPackageToHistory(PackageModel package) {
    _activePackages.insert(0, package);
    notifyListeners();
  }
}
