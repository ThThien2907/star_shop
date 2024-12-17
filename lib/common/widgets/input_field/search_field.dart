import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.onSubmitted});

  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xff09090C),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            hintText: 'Search',
            prefixIcon: const Icon(
              Icons.search_outlined,
              color: AppColors.subtextColor,
            ),),
      ),
    );
  }
}
