import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_shop/common/widgets/network_image/app_network_image.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/order/entities/order_entity.dart';

class OrderPageItem extends StatelessWidget {
  const OrderPageItem({super.key, required this.orderEntity,});

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppNetworkImage(
          width: 80,
          height: 80,
          image: orderEntity.productsOrdered[0].images,
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
                  _productOrderedID(context),

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
    // Color colorStatus = ;
    return Text(orderEntity.status,
      style: TextStyle(color: setStatusColor(orderEntity.status), fontSize: 16),);
  }

  Widget _productOrderedTitle(BuildContext context) {
    return Text(
      orderEntity.productsOrdered[0].title,
      style: const TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _productOrderedID(BuildContext context) {
    return Text(
      'OrderID: ${orderEntity.orderID}',
      style: const TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _productOrderedPrice(BuildContext context) {
    return Text(
      '\$${orderEntity.totalPrice}',
      style: const TextStyle(color: AppColors.textColor, fontSize: 16),
    );
  }

  Color setStatusColor(String status){
    if(status == 'Pending'){
      return AppColors.primaryColor;
    }
    else if(status == 'Ongoing'){
      return AppColors.primaryColor;
    }
    else if(status == 'Complete'){
      return AppColors.successColor;
    }
    else {
      return AppColors.red;
    }
  }
}
