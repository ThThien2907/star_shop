import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_shop/configs/assets/app_vectors.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/presentation/product/pages/product_descriptions_page.dart';

class ProductDetailInformation extends StatelessWidget {
  const ProductDetailInformation({super.key, required this.productEntity,});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    String productDescription = productEntity.description.replaceAll('\\n', '\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _productTitle(context),
        const SizedBox(
          height: 16,
        ),
        _productPriceAndRating(context),
        const SizedBox(
          height: 16,
        ),
        _productQuantity(context),
        const SizedBox(
          height: 32,
        ),
        _productDescription(context, productDescription),
      ],
    );
  }

  Widget _productTitle(BuildContext context){
    return Text(
      productEntity.title,
      style: const TextStyle(
        fontSize: 20,
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _productPriceAndRating(BuildContext context){
    return Row(
      children: [
        Text(
          'Price: \$${productEntity.price}',
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        SvgPicture.asset(AppVectors.starCircleIcon),
        const SizedBox(
          width: 4,
        ),
        Text(
          '${productEntity.rating.toString()} (${productEntity.reviews.length.toString()} Reviews)',
          style: const TextStyle(
              fontSize: 16, color: AppColors.textColor),
        ),
      ],
    );
  }

  Widget _productQuantity(BuildContext context){
    return Container(
      width: double.infinity,
      alignment: Alignment.topRight,
      child: Text(
        'Quantity in stock: ${productEntity.quantityInStock.toString()}',
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.subtextColor,
        ),
      ),
    );
  }

  Widget _productDescription(BuildContext context, String productDescription){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Descriptions',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          productDescription,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.subtextColor,
          ),
          maxLines: 15,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDescriptionsPage(
                        productDescription: productDescription,
                      ),
                ),
              );
            },
            child: const Text(
              'See more...',
              style: TextStyle(
                color: AppColors.textColor,
                decoration: TextDecoration.underline,
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}
