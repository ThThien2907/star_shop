import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/presentation/notification/pages/notification_page.dart';

class AppBarNotificationIcon extends StatelessWidget implements PreferredSizeWidget {
  const AppBarNotificationIcon({
    super.key,
    this.title,
    this.widget,
    this.height,
    this.centerTitle,
  });

  final String? title;
  final Widget? widget;
  final double? height;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget ??
          Text(
            title!,
            style: const TextStyle(
              color: AppColors.textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
      toolbarHeight: height ?? 70,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NotificationPage()));
            },
            icon: const Icon(
              Icons.notifications_none,
              size: 28,
              color: AppColors.textColor,
            ),
          ),
        ),
      ],
      scrolledUnderElevation: 0.0,
      centerTitle: centerTitle ?? false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 70);
}
