import 'package:flutter/material.dart';
// Nhớ check lại đường dẫn import Model của ông cho chuẩn nhé
import 'package:telecom_app/views/notifications/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  // 1. Danh sách Khuyến mại (Tab bên trái)
  final List<NotificationModel> _promotions = [
    NotificationModel(
      id: 'p1',
      title: 'Khuyến mại nạp thẻ 50%',
      content:
          'Duy nhất hôm nay, nạp thẻ nhận ngay ưu đãi khủng 50% giá trị thẻ nạp vào tài khoản khuyến mại.',
      time: '1 thg 4',
      type: NotificationType.promotion,
      layoutType: NotificationLayoutType.coin, // Hiện hũ tiền, căn trái
    ),
    NotificationModel(
      id: 'p2',
      title: 'Voucher 30k tri ân khách hàng',
      content:
          'Bạn nhận được mã giảm giá 30.000đ khi đăng ký gói cước tháng bất kỳ.',
      time: '30 thg 3',
      type: NotificationType.promotion,
      layoutType: NotificationLayoutType.coin,
    ),
  ];

  // 2. Danh sách Thông báo hệ thống (Tab bên phải)
  final List<NotificationModel> _systems = [
    NotificationModel(
      id: 's1',
      title: 'Chốt! Bạn có quà nè.',
      content:
          'Nguyễn Việt Anh ****099 đã gửi cho bạn phần quà gói cước ON12 3 ngày. Hãy tận hưởng và gửi lời cảm ơn đến Nguyễn Việt Anh nhé.',
      time: '2 thg 4',
      type: NotificationType.system,
      layoutType: NotificationLayoutType.gift, // Hiện hộp quà, căn giữa
    ),
    NotificationModel(
      id: 's2',
      title: 'Đăng ký thành công gói ON5',
      content:
          'Hệ thống đã kích hoạt thành công gói cước ON5 cho thuê bao của bạn. Ưu đãi 5GB/ngày.',
      time: '1 thg 4',
      type: NotificationType.system,
      layoutType: NotificationLayoutType.coin, // Hiện hũ tiền, căn trái
    ),
  ];

  // --- LOGIC XỬ LÝ ---

  // Lấy danh sách hiển thị dựa trên Tab đang chọn
  List<NotificationModel> getByType(bool isSystemTab) {
    return isSystemTab ? _systems : _promotions;
  }

  // Xóa sạch thông báo của RIÊNG Tab đang đứng
  void clearByTab(bool isSystemTab) {
    if (isSystemTab) {
      _systems.clear();
    } else {
      _promotions.clear();
    }
    notifyListeners(); // Thông báo cho giao diện vẽ lại (quan trọng nhất)
  }

  // Nếu muốn xóa toàn bộ cả 2 tab (dùng khi cần)
  void clearAll() {
    _promotions.clear();
    _systems.clear();
    notifyListeners();
  }
}
