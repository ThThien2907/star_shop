import 'package:flutter/material.dart';
import 'package:star_shop/configs/assets/app_images.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({super.key, required this.width, required this.height, required this.image, this.radius});

  final double width;
  final double height;
  final double? radius;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: radius != null ? BorderRadius.circular(radius!) : BorderRadius.zero,
        child: FadeInImage.assetNetwork(
          placeholder: AppImages.imgNotFound,
          image: image,
          imageErrorBuilder:
              (context, error, stackTrace) {
            return Image.asset(
              AppImages.imgNotFound,
            );
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
