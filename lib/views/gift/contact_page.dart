import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telecom_app/views/gift/gift_provider.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 🎯 Dùng context.watch để lắng nghe thay đổi khi lọc danh sách
    final giftVM = context.watch<GiftProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            giftVM.filterContacts(''); // Reset lại danh sách khi quay về
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Tìm từ danh bạ",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. THANH SEARCH CÓ LOGIC LỌC
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: giftVM.searchController, // Gắn controller từ Provider
              onChanged: (value) =>
                  giftVM.filterContacts(value), // 🎯 Gọi hàm lọc
              decoration: InputDecoration(
                hintText: "Tìm từ danh bạ",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                // Nút X để xóa nhanh nội dung tìm kiếm
                suffixIcon: giftVM.searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.grey),
                        onPressed: () => giftVM.filterContacts(''), // Xóa trắng
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // 2. DANH SÁCH DANH BẠ (Hiển thị kết quả sau khi lọc)
          Expanded(
            child: giftVM.filteredContacts.isEmpty
                ? _buildEmptyResult() // Hiện thông báo nếu không tìm thấy
                : ListView.builder(
                    itemCount: giftVM.filteredContacts.length,
                    itemBuilder: (context, index) {
                      final contact = giftVM.filteredContacts[index];
                      return _buildContactTile(context, giftVM, contact);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // --- UI KHI KHÔNG TÌM THẤY KẾT QUẢ ---
  Widget _buildEmptyResult() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.contact_page_outlined, size: 60, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            "Không tìm thấy số điện thoại nào",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // --- TILE DANH BẠ ---
  Widget _buildContactTile(
    BuildContext context,
    GiftProvider vm,
    dynamic contact,
  ) {
    return ListTile(
      onTap: () {
        vm.selectContact(contact); // Chọn xong gán vào ô SĐT ở màn hình trước
        vm.filterContacts(''); // Reset lại search trước khi thoát
        Navigator.pop(context); // Quay về màn hình tặng
      },
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFF0F0F0),
        child: Text(
          contact.name.isNotEmpty ? contact.name[0].toUpperCase() : "?",
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        contact.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(
        contact.phone,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
