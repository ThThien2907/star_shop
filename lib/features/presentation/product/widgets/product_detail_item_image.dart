import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class ProductDetailItemImage extends StatelessWidget {
  const ProductDetailItemImage({
    super.key,
    required this.selectedImage,
    required this.images,
    required this.onTap, required this.index,
  });

  final int selectedImage;
  final int index;
  final List<String> images;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: index == selectedImage
              ? Border.all(color: AppColors.primaryColor, width: 2)
              : Border.all(color: AppColors.grey, width: 2),
          image: DecorationImage(
            image: NetworkImage(images[index]),
            fit: BoxFit.cover,
            opacity: index == selectedImage ? 1 : 0.5,
          ),
        ),
      ),
    );
  }
}
