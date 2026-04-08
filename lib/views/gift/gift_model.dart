import 'package:telecom_app/views/home/package_model.dart';

class GiftTransaction {
  final String recipientPhone;
  final PackageModel package;
  final String transactionId;
  final DateTime timestamp;

  GiftTransaction({
    required this.recipientPhone,
    required this.package,
    required this.transactionId,
    required this.timestamp,
  });
}

// Model cho danh bạ (nếu ông muốn làm list chọn sđt)
class ContactModel {
  final String name;
  final String phone;
  ContactModel({required this.name, required this.phone});
}
