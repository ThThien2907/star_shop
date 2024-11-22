import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_shop/common/widgets/network_image/app_network_image.dart';
import 'package:star_shop/configs/assets/app_vectors.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: AppNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  image: productEntity.images[0],
                  radius: 10,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _productTitle(context),
                      const SizedBox(
                        height: 8,
                      ),
                      _productPrice(context),
                      const SizedBox(
                        height: 8,
                      ),
                      _productRating(context),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: _favoriteButton(context),
          ),
        ],
      ),
    );
  }

  Widget _productTitle(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Text(
        productEntity.title,
        style: const TextStyle(
          color: AppColors.textColor,
          fontSize: 16,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _productPrice(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$${productEntity.price}',
          style: const TextStyle(
            color: AppColors.textColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '\$${productEntity.oldPrice}',
          style: const TextStyle(
            color: AppColors.subtextColor,
            fontSize: 16,
            decoration: TextDecoration.lineThrough,
            decorationColor: AppColors.subtextColor,
            decorationThickness: 2,
          ),
        ),
      ],
    );
  }

  Widget _productRating(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppVectors.starCircleIcon),
        const SizedBox(
          width: 5,
        ),
        Text(
          productEntity.rating.toString(),
          style: const TextStyle(
            color: AppColors.subtextColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '(${productEntity.reviews.length.toString()})',
          style: const TextStyle(
            color: AppColors.subtextColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _favoriteButton(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Center(
          child: Icon(
            Icons.favorite_border,
            color: AppColors.primaryColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}
