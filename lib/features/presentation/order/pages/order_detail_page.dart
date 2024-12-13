import 'package:flutter/material.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/order/entities/order_entity.dart';
import 'package:star_shop/features/presentation/order/widgets/order_detail_page_product_ordered_item.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key, required this.orderEntity});

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    String statusText = '';
    Color statusColor = AppColors.primaryColor;
    if(orderEntity.status == 'Pending'){
      statusText = 'Order is pending!';
    }
    if(orderEntity.status == 'Ongoing'){
      statusText = 'Order is being delivered';
    }
    if(orderEntity.status == 'Complete'){
      statusText = 'The order has been delivered successfully';
      statusColor = AppColors.successColor;
    }
    if(orderEntity.status == 'Canceled'){
      statusText = 'The order has been canceled';
      statusColor = AppColors.removeColor;
    }

    return Scaffold(
      appBar: const BasicAppBar(
        title: 'Order Detail',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4, right: 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: statusColor,
              ),
              child: Text(statusText, style: const TextStyle(fontSize: 16, color: AppColors.textColor),),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Delivery Address',
              style: TextStyle(fontSize: 16, color: AppColors.primaryTextColor),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.grey,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: _addressDetail(context),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Ordered Products',
              style: TextStyle(fontSize: 16, color: AppColors.primaryTextColor),
            ),
            const SizedBox(
              height: 16,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return OrderDetailPageProductOrderedItem(
                    productOrderedEntity: orderEntity.productsOrdered[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: orderEntity.productsOrdered.length,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total Price: \$${orderEntity.totalPrice}',
                  style: const TextStyle(fontSize: 16, color: AppColors.textColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _addressDetail(
    BuildContext context,
  ) {
    return SizedBox(
      height: 50,
      child: Text(
        '${orderEntity.detailedAddress}, ${orderEntity.ward}, ${orderEntity.district}, ${orderEntity.city}',
        style: const TextStyle(fontSize: 16, color: AppColors.subtextColor),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
