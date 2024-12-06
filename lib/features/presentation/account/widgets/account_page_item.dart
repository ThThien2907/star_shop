import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class AccountPageItem extends StatelessWidget {
  const AccountPageItem({super.key, required this.title, this.color, required this.icon, required this.onTap, this.hideArrow, });

  final Color? color;
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool? hideArrow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: color ?? AppColors.subtextColor, size: 28,),
            const SizedBox(width: 16,),
            Text(title, style: TextStyle(fontSize: 16, color: color ?? AppColors.textColor),),
            const Spacer(),
            if(hideArrow == null)
            Icon(Icons.arrow_forward_ios, color: color ?? AppColors.subtextColor, size: 14,),
          ],
        ),
      ),
    );
  }
}
