// file: user_model.dart
class UserModel {
  final String uid;
  final String phone;
  final String name;
  final int points;

  UserModel({
    required this.uid,
    required this.phone,
    required this.name,
    this.points = 0,
  });

  // Ép kiểu từ dữ liệu Firebase trả về sang Object Flutter
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      uid: documentId,
      phone: data['phone'] ?? '',
      name: data['name'] ?? 'Khách hàng', // Lỡ mất tên thì hiển thị mặc định
      points: data['points'] ?? 0,
    );
  }

  // Đóng gói thành Map để đẩy lên Firebase lưu trữ
  Map<String, dynamic> toMap() {
    return {'phone': phone, 'name': name, 'points': points};
  }
}
