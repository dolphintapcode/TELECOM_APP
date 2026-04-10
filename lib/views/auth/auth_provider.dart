import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Đổi lại đường dẫn import file UserModel cho đúng với máy ông nhé
import '../../data/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 🎯 HÀM LÕI 1: KIỂM TRA SĐT TRONG DATABASE
  Future<bool> checkPhoneExists(String phone) async {
    try {
      _setLoading(true);

      // Chọc vào bảng 'users' (collection) trên Firestore
      // Tìm xem có cái document nào có trường 'phone' khớp với số người dùng nhập không
      var querySnapshot = await _firestore
          .collection('users')
          .where('phone', isEqualTo: phone)
          .get();

      _setLoading(false);

      // Nếu danh sách trả về KHÔNG RỖNG => SĐT ĐÃ TỒN TẠI
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      _setLoading(false);
      print("Lỗi check phone: $e");
      return false; // Nếu lỗi mạng các kiểu, tạm coi là chưa tồn tại
    }
  }

  // Hàm nội bộ để bật/tắt vòng xoay loading
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // 🎯 HÀM LÕI 2: ĐĂNG KÝ USER MỚI VÀ LƯU LÊN FIRESTORE
  Future<bool> registerUser({
    required String name,
    required String phone,
    required String uid,
  }) async {
    try {
      _setLoading(true);

      // Tạo object User mới
      UserModel newUser = UserModel(
        uid: uid,
        phone: phone,
        name: name,
        points: 1000, // Tặng luôn 1000 điểm làm vốn khi mới đki
      );

      // Lưu vào collection 'users' với ID là số điện thoại (để sau này dễ tìm)
      await _firestore.collection('users').doc(phone).set(newUser.toMap());

      _currentUser = newUser; // Lưu vào state để dùng toàn app
      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      print("Lỗi đăng ký: $e");
      return false;
    }
  }

  Future<bool> loginUser({required String phone}) async {
    try {
      _setLoading(true);
      final doc = await _firestore.collection('users').doc(phone).get();
      _setLoading(false);

      if (!doc.exists || doc.data() == null) {
        return false;
      }

      _currentUser = UserModel.fromMap(doc.data()!, doc.id);
      notifyListeners();
      return true;
    } catch (e) {
      _setLoading(false);
      print("Lỗi đăng nhập: $e");
      return false;
    }
  }

  Future<bool> exchangePoints(int packagePoints) async {
    if (_currentUser == null) return false;
    if (_currentUser!.points < packagePoints) return false;

    try {
      _setLoading(true);
      final newPoints = _currentUser!.points - packagePoints;
      await _firestore.collection('users').doc(_currentUser!.phone).update({
        'points': newPoints,
      });
      _currentUser = UserModel(
        uid: _currentUser!.uid,
        phone: _currentUser!.phone,
        name: _currentUser!.name,
        points: newPoints,
      );
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setLoading(false);
      print("Lỗi cập nhật điểm: $e");
      return false;
    }
  }
}
