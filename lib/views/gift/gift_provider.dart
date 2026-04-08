import 'package:flutter/material.dart';
import 'gift_model.dart';

class GiftProvider extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController searchController =
      TextEditingController(); // Thêm cho ô Search

  // Danh bạ gốc (Data thô)
  final List<ContactModel> _allContacts = [
    ContactModel(name: 'Cô Thanh', phone: '0979111222'),
    ContactModel(name: 'Chú Dũng', phone: '0988123123'),
    ContactModel(name: 'Hà Trần', phone: '0977444555'),
    ContactModel(name: 'Bách Khi', phone: '0355666777'),
    ContactModel(name: 'Em Iu ❤️', phone: '0966850850'),
    ContactModel(name: 'Mẹ Iu 👑', phone: '0979426127'),
  ];

  // Danh bạ sau khi lọc (Dùng để hiển thị lên UI)
  List<ContactModel> _filteredContacts = [];

  GiftProvider() {
    // Khởi tạo danh sách lọc bằng danh sách gốc
    _filteredContacts = List.from(_allContacts);
  }

  List<ContactModel> get filteredContacts => _filteredContacts;

  bool _isValid = false;
  bool get isValid => _isValid;

  // --- LOGIC SEARCH ---
  void filterContacts(String query) {
    if (query.isEmpty) {
      _filteredContacts = List.from(_allContacts);
    } else {
      _filteredContacts = _allContacts.where((contact) {
        final nameLower = contact.name.toLowerCase();
        final phoneLower = contact.phone.toLowerCase();
        final searchLower = query.toLowerCase();

        // Lọc theo tên hoặc số điện thoại
        return nameLower.contains(searchLower) ||
            phoneLower.contains(searchLower);
      }).toList();
    }
    notifyListeners(); // Vẽ lại giao diện khi danh sách thay đổi
  }

  void selectContact(ContactModel contact) {
    phoneController.text = contact.phone;
    _isValid = true;
    notifyListeners();
  }

  void checkValidation(String value) {
    _isValid = value.length >= 10;
    notifyListeners();
  }

  void clear() {
    phoneController.clear();
    searchController.clear();
    _filteredContacts = List.from(
      _allContacts,
    ); // Reset lại danh sách khi thoát
    _isValid = false;
  }
}
