import 'package:flutter/material.dart';
import 'package:star_shop/common/widgets/button/app_button.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class ConfirmEventBottomSheet extends StatelessWidget {
  const ConfirmEventBottomSheet(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.confirmText,
      required this.onPressedCancelButton,
      required this.onPressedYesButton});

  final VoidCallback onPressedCancelButton;
  final VoidCallback onPressedYesButton;
  final String title;
  final String subtitle;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 18, color: AppColors.textColor),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 16, color: AppColors.subtextColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        Row(
          children: [
            Expanded(
              child: Builder(builder: (context) {
                return AppButton(
                  onPressed: onPressedCancelButton,
                  title: 'Cancel',
                  color: AppColors.cancelColor,
                  height: 60,
                );
              }),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Builder(builder: (context) {
                return AppButton(
                  onPressed: onPressedYesButton,
                  title: confirmText,
                  height: 60,
                  color: AppColors.removeColor,
                );
              }),
            ),
          ],
        )
      ],
    );
  }
}
