import 'package:flutter/material.dart';
import 'package:telecom_app/views/home/menu_content.dart';

class PolicyArticlePage extends StatelessWidget {
  const PolicyArticlePage({
    super.key,
    required this.title,
    required this.sections,
  });

  final String title;
  final List<PolicySection> sections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        titleSpacing: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        itemCount: sections.length,
        separatorBuilder: (_, _) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final section = sections[index];
          return _ArticleSection(section: section);
        },
      ),
    );
  }
}

class _ArticleSection extends StatelessWidget {
  const _ArticleSection({required this.section});

  final PolicySection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          section.content,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF5F6368),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
