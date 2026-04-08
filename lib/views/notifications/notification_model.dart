// Thêm enum này vào đầu file nhé Trung
enum NotificationLayoutType { gift, coin }

enum NotificationType { promotion, system }

class NotificationModel {
  final String id;
  final String title;
  final String content;
  final String time;
  final NotificationType type;
  // Thêm biến này để màn chi tiết biết đường mà vẽ
  final NotificationLayoutType layoutType;

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
    required this.type,
    this.layoutType =
        NotificationLayoutType.coin, // Mặc định là kiểu căn trái (coin)
  });
}
