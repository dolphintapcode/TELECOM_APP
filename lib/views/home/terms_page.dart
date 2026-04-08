import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F6),
      appBar: AppBar(
        title: const Text(
          'Điều khoản sử dụng',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
        ),
        backgroundColor: const Color(0xFFF5F5F6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _TermsSection(
            title: '1. Quy định chung',
            content:
                'Người dùng cần cung cấp thông tin chính xác khi đăng ký và chịu trách nhiệm với tài khoản của mình.',
          ),
          SizedBox(height: 16),
          _TermsSection(
            title: '2. Giao dịch dịch vụ',
            content:
                'Mọi giao dịch mua gói cước, đổi điểm hoặc tặng quà sẽ được ghi nhận trên hệ thống và không thể hoàn tác trong một số trường hợp.',
          ),
          SizedBox(height: 16),
          _TermsSection(
            title: '3. Bảo mật thông tin',
            content:
                'Ứng dụng cam kết bảo vệ thông tin cá nhân theo chính sách hiện hành và chỉ sử dụng dữ liệu để phục vụ trải nghiệm người dùng.',
          ),
        ],
      ),
    );
  }
}

class _TermsSection extends StatelessWidget {
  const _TermsSection({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
