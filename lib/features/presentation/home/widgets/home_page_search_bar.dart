import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class HomePageSearchBar extends StatelessWidget {
  const HomePageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        backgroundColor: const Color(0xff09090C),
        minimumSize: Size(MediaQuery.of(context).size.width, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.search_outlined,
            size: 26,
            color: AppColors.subtextColor,
          ),
          SizedBox(
            width: 16,
          ),
          // AnimatedTextKit(
          //   repeatForever: true,
          //   animatedTexts: [
          //     TypewriterAnimatedText('Find your favorite items',
          //         textStyle: TextStyle(
          //           fontSize: 16,
          //           color: AppColors.subtextColor,
          //         ),
          //         speed: Duration(milliseconds: 80)),
          //   ],
          //   onTap: () {
          //     print('aaaa');
          //   },
          // ),
        ],
      ),
    );
  }
}
