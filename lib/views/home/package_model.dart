import 'package:telecom_app/gen/assets.gen.dart';

// 1. Model cho từng ứng dụng nhỏ
class AppItemModel {
  final String name;
  final String developer;
  final AssetGenImage icon;

  AppItemModel({
    required this.name,
    required this.developer,
    required this.icon,
  });
}

// 2. Model chính cho gói cước
class PackageModel {
  final String title;
  final String price;
  final AssetGenImage image;
  final String description;
  final String duration; // THÊM BIẾN NÀY ĐỂ ĐỘNG HÓA THỜI GIAN
  final List<AppItemModel> apps;
  final bool isExpired;

  PackageModel({
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.duration, // Bắt buộc phải có
    required this.apps,
    this.isExpired = false,
  });
}
