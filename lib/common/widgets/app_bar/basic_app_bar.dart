import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({super.key, required this.title, this.height, this.action});

  final Widget title;
  final List<Widget>? action;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      toolbarHeight: height ?? 70,
      actions: action,
      scrolledUnderElevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 70);
}
