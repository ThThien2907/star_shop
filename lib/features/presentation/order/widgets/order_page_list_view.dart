import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/order/entities/order_entity.dart';
import 'package:star_shop/features/presentation/order/bloc/order_display_cubit.dart';
import 'package:star_shop/features/presentation/order/pages/order_detail_page.dart';
import 'package:star_shop/features/presentation/order/widgets/order_page_item.dart';

class OrderPageListView extends StatelessWidget {
  const OrderPageListView(
      {super.key, required this.listOrder, required this.isAdmin,});

  final List<OrderEntity> listOrder;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: listOrder.isNotEmpty ? ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailPage(orderEntity: listOrder[index], isAdmin: isAdmin)));
              if(result == 'Data has changed'){
                context.read<OrderDisplayCubit>().getOrder(isAdmin);
              }
            },
            child: OrderPageItem(orderEntity: listOrder[index],),
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
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.list_alt,
            color: AppColors.subtextColor,
            size: 92,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'No Orders!',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'You don’t have any orders at this time.',
            style: TextStyle(
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
