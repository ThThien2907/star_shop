import 'package:flutter/material.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BasicAppBar(
        title: 'Notifications',
        centerTitle: true,
        action: [
          Icon(
            Icons.notifications_none,
            size: 28,
            color: AppColors.textColor,
          ),
          SizedBox(width: 14,)
        ],
      ),
    );
  }
}
