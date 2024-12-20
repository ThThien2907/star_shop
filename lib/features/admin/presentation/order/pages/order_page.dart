import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/order/entities/order_entity.dart';
import 'package:star_shop/features/presentation/order/bloc/order_display_cubit.dart';
import 'package:star_shop/features/presentation/order/bloc/order_display_state.dart';
import 'package:star_shop/features/presentation/order/widgets/order_page_list_view.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TabBar(
          indicator: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          indicatorPadding: const EdgeInsets.all(8),
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: AppColors.textColor,
          labelColor: AppColors.textColor,
          tabs: const [
            Tab(child: Text('Pending', overflow: TextOverflow.ellipsis,),),
            Tab(child: Text('Ongoing', overflow: TextOverflow.ellipsis,),),
            Tab(child: Text('Complete', overflow: TextOverflow.ellipsis,),),
            Tab(child: Text('Canceled', overflow: TextOverflow.ellipsis,),),
          ],
        ),
        body: BlocBuilder<OrderDisplayCubit, OrderDisplayState>(
            builder: (context, state) {
              if (state is OrderDisplayInitialState) {
                context.read<OrderDisplayCubit>().getOrder(true);
              }

              if (state is OrderDisplayLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (state is OrderDisplayLoadFailure) {
                return Center(
                  child: AppErrorWidget(
                    onPress: () {
                      context.read<OrderDisplayCubit>().getOrder(true);
                    },
                  ),
                );
              }

              if (state is OrderDisplayLoaded) {
                List<OrderEntity> listPending = context.read<OrderDisplayCubit>().listPending;
                List<OrderEntity> listOngoing = context.read<OrderDisplayCubit>().listOngoing;
                List<OrderEntity> listComplete = context.read<OrderDisplayCubit>().listComplete;
                List<OrderEntity> listCanceled = context.read<OrderDisplayCubit>().listCanceled;


                return TabBarView(
                  children: [
                    OrderPageListView(listOrder: listPending, isAdmin: true,),
                    OrderPageListView(listOrder: listOngoing, isAdmin: true,),
                    OrderPageListView(listOrder: listComplete, isAdmin: true,),
                    OrderPageListView(listOrder: listCanceled, isAdmin: true,),
                  ],
                );
              }

              return Container();
            }),
      ),
    );
  }
}
