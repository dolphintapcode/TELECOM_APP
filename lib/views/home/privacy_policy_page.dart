import 'package:flutter/material.dart';
import 'package:telecom_app/views/home/menu_content.dart';
import 'package:telecom_app/views/home/policy_article_page.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PolicyArticlePage(
      title: 'Chính sách bảo vệ dữ liệu cá nhân',
      sections: MenuContent.privacyPolicy,
    );
  }
}
