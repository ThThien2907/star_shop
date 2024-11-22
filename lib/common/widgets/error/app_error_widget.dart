import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget(
      {super.key, required this.onPress});

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Something wrong...',
          style: TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton.icon(
          icon: const Icon(Icons.refresh, color: AppColors.textColor,),
          onPressed: onPress,
          label: const Text(
            'Press to reload',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.textColor,
            ),
          ),
        ),
      ],
    );
  }
}
