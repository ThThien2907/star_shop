import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_shop/common/widgets/network_image/app_network_image.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';

class OrderDetailPageProductOrderedItem extends StatelessWidget {
  const OrderDetailPageProductOrderedItem(
      {super.key,
      required this.productOrderedEntity,});

  final ProductOrderedEntity productOrderedEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppNetworkImage(
          width: 80,
          height: 80,
          image: productOrderedEntity.images,
          radius: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
            child: SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _productOrderedTitle(context),
                  _productOrderedQuantity(context),
                  _productOrderedPrice(context),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _productOrderedQuantity(BuildContext context) {
    return Text(
      'Quantity: ${productOrderedEntity.quantity}',
      style: const TextStyle(color: AppColors.subtextColor, fontSize: 16),
    );
  }

  Widget _productOrderedTitle(BuildContext context) {
    return Text(
      productOrderedEntity.title,
      style: const TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _productOrderedPrice(BuildContext context) {
    return Text(
      '\$${productOrderedEntity.totalPrice}',
      style: const TextStyle(color: AppColors.textColor, fontSize: 18),
    );
  }
}
