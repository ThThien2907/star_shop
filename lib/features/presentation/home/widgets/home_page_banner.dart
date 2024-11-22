import 'package:flutter/material.dart';
import 'package:star_shop/configs/assets/app_images.dart';

class HomePageBanner extends StatelessWidget {
  const HomePageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppImages.banner),
        ),
      ),
    );
  }
}
