import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({
    super.key,
    this.title,
    this.widget,
    this.height,
    this.action,
    this.centerTitle,
  });

  final String? title;
  final Widget? widget;
  final List<Widget>? action;
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
      actions: action,
      scrolledUnderElevation: 0.0,
      centerTitle: centerTitle ?? false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 70);
}
