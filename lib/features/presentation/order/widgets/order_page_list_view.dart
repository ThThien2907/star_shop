import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/order/entities/order_entity.dart';
import 'package:star_shop/features/presentation/order/pages/order_detail_page.dart';
import 'package:star_shop/features/presentation/order/widgets/order_page_item.dart';

class OrderPageListView extends StatelessWidget {
  const OrderPageListView(
      {super.key, required this.listOrder, required this.status, required this.colorStatus,});

  final List<OrderEntity> listOrder;
  final String status;
  final Color colorStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: listOrder.isNotEmpty ? ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailPage(orderEntity: listOrder[index])));
            },
            child: OrderPageItem(
              productOrderedEntity: listOrder[index].productsOrdered[0],
              status: status,
              totalPrice: listOrder[index].totalPrice,
              colorStatus: colorStatus,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
        itemCount: listOrder.length,
      ) : _emptyOrder(context),
    );
  }

  Widget _emptyOrder(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.list_alt,
            color: AppColors.subtextColor,
            size: 92,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'No $status Orders!',
            style: const TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'You don’t have any $status orders at this time.',
            style: const TextStyle(
              color: AppColors.subtextColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
