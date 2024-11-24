import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:star_shop/configs/assets/app_images.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(
      {super.key,
      required this.width,
      required this.height,
      required this.image,
      this.radius});

  final double width;
  final double height;
  final double? radius;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(radius!)
          ),
        ),
        placeholder: (context, url) => Image.asset(AppImages.imgNotFound),
        errorWidget: (context, url, error) => Image.asset(AppImages.imgNotFound),
      ),
    );
  }
}
