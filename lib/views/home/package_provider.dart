import 'package:flutter/material.dart';
import 'package:telecom_app/gen/assets.gen.dart';
import 'package:telecom_app/views/home/app_data.dart';
import 'package:telecom_app/views/home/package_model.dart';

class PackageProvider extends ChangeNotifier {
  // DANH SÁCH GÓI THEO NGÀY
  final List<PackageModel> dailyPackages = [
    PackageModel(
      title: 'Gói ngày tổng hợp DataON',
      price: '3.000đ',
      image: Assets.images.home,
      duration: '1 ngày',
      description:
          'Truy cập các ứng dụng Zalo, Instagram, Google Drive... sử dụng tối đa data 750MB/ngày.',
      apps: fullAppCombo, // <--- Dùng biến chung
    ),
    PackageModel(
      title: 'Gói Facebook ngày DataON',
      price: '3.000đ',
      image: Assets.images.facebook,
      duration: '1 ngày', // <--- THÊM VÀO ĐÂY
      description:
          'Truy cập không giới hạn Facebook và Messenger tốc độ cao mỗi ngày.',
      apps: [
        AppItemModel(
          name: "Facebook",
          developer: "Meta",
          icon: Assets.icons.face1,
        ),
      ],
    ),
    PackageModel(
      title: 'Gói Youtube ngày DataON',
      price: '3.000đ',
      image: Assets.images.youtube,
      duration: '1 ngày', // <--- THÊM VÀO ĐÂY
      description:
          'Thoải mái xem video Youtube không giới hạn dung lượng data.',
      apps: [
        AppItemModel(
          name: "YouTube",
          developer: "Google",
          icon: Assets.icons.youtube1,
        ),
      ],
    ),
  ];

  // DANH SÁCH GÓI THEO TUẦN
  final List<PackageModel> weeklyPackages = [
    PackageModel(
      title: 'Gói tuần tổng hợp DataON',
      price: '10.000đ',
      image: Assets.images.home,
      duration: '7 ngày',
      description:
          'Truy cập các ứng dụng Zalo, Instagram, Google Drive... ưu đãi theo tuần.',
      apps: fullAppCombo, // <--- Dùng lại biến chung, không cần code lại!
    ),
  ];

  // DANH SÁCH GÓI THEO THÁNG
  final List<PackageModel> monthlyPackages = [
    PackageModel(
      title: 'Gói tháng tổng hợp DataON',
      price: '30.000đ',
      image: Assets.images.home,
      duration: '30 ngày',
      description:
          'Truy cập các ứng dụng Zalo, Instagram, Google Drive... tiết kiệm cả tháng.',
      apps: fullAppCombo, // <--- Tiếp tục dùng biến chung
    ),
  ];
}
