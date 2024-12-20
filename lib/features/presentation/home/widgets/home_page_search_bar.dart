import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/presentation/search/pages/product_search_page.dart';

class HomePageSearchBar extends StatelessWidget {
  const HomePageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductSearchPage(isEdit: false)));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        backgroundColor: const Color(0xff09090C),
        minimumSize: Size(MediaQuery.of(context).size.width, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_outlined,
            size: 26,
            color: AppColors.subtextColor,
          ),
          const SizedBox(
            width: 16,
          ),
          AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TypewriterAnimatedText('Find your favorite items',
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: AppColors.subtextColor,
                  ),
                  speed: const Duration(milliseconds: 80)),
            ],
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductSearchPage(isEdit: false)));
            },
          ),
        ],
      ),
    );
  }
}
