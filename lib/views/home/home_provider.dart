import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  // 1. Quản lý Tab của Bottom Navigation
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  // 2. Controller của Banner (Tách khỏi Page để tránh lãng phí bộ nhớ)
  final PageController bannerController = PageController(viewportFraction: 0.9);

  // Hàm chuyển Tab
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Hàm xử lý khi nhấn vào Banner
  void onBannerTap(int index) {
    print("User nhấn vào banner số: $index");
  }

  @override
  void dispose() {
    bannerController.dispose();
    super.dispose();
  }
}
