import 'package:flutter/material.dart';
import 'package:telecom_app/views/home/home_provider.dart';
import 'package:provider/provider.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final homeVM = context.watch<HomeProvider>();
    return AspectRatio(
      aspectRatio: 2.8 / 1,
      child: PageView.builder(
        controller: homeVM.bannerController,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/banner${index + 1}.png',
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
