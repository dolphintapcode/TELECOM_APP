import 'package:flutter/material.dart';

class ExchangeProvider extends ChangeNotifier {
  // Mock data: Tên user đăng nhập và số điểm
  final String _userName = "DƯƠNG ĐÌNH TRUNG"; // Đổi thành tên ông cho oách
  int _points = 20224;

  String get userName => _userName;
  int get points => _points;

  // Hàm trừ điểm khi đổi gói thành công
  bool exchangePackage(int packagePoints) {
    if (_points >= packagePoints) {
      _points -= packagePoints; // Trừ điểm
      notifyListeners(); // Báo cho giao diện (thẻ đỏ) update lại số mới
      return true; // Đổi thành công
    }
    return false; // Điểm không đủ
  }

  // Tiện ích để format số điểm có dấu phẩy (vd: 20,224)
  String get formattedPoints {
    return _points.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }
}
