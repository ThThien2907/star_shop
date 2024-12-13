import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_shop/common/widgets/network_image/app_network_image.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';

class OrderPageItem extends StatelessWidget {
  const OrderPageItem({super.key, required this.productOrderedEntity, required this.status, required this.totalPrice, required this.colorStatus});

  final ProductOrderedEntity productOrderedEntity;
  final String status;
  final num totalPrice;
  final Color colorStatus;

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
                  _productOrderedTitle(
                    context,
                  ),
                  Row(
                    children: [
                      _productOrderedPrice(
                        context,
                      ),
                      const Spacer(),
                      _orderStatus(context),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _orderStatus(BuildContext context) {
    return Text(status,
      style: TextStyle(color: colorStatus, fontSize: 16),);
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
      '\$$totalPrice',
      style: const TextStyle(color: AppColors.textColor, fontSize: 16),
    );
  }
}
