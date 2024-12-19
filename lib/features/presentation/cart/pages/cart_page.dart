import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:star_shop/common/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:star_shop/common/widgets/button/app_button.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';
import 'package:star_shop/features/presentation/cart/bloc/cart_display_cubit.dart';
import 'package:star_shop/features/presentation/cart/bloc/cart_display_state.dart';
import 'package:star_shop/features/presentation/cart/widgets/cart_page_confirm_remove_product.dart';
import 'package:star_shop/features/presentation/cart/widgets/cart_page_product_ordered_item.dart';
import 'package:star_shop/features/presentation/cart/widgets/cart_page_sub_total.dart';
import 'package:star_shop/features/presentation/checkout/pages/checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartDisplayCubit, CartDisplayState>(
          builder: (context, state) {
        if (state is CartDisplayInitialState) {
          context.read<CartDisplayCubit>().getProductsFromCart();
        }

        if (state is CartDisplayLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        if (state is CartDisplayLoadFailure) {
          return Center(
            child: AppErrorWidget(
              onPress: () {
                context.read<CartDisplayCubit>().getProductsFromCart();
              },
            ),
          );
        }

        if (state is CartDisplayLoaded) {
          List<ProductOrderedEntity> products = state.products;

          if(products.isEmpty){
            return _emptyCart(context);
          }

          num subTotal = 0;

          for (var e in products) {
            subTotal += e.totalPrice;
          }

          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      ProductOrderedEntity productOrderedEntity =
                          products[index];
                      return SizedBox(
                        width: double.infinity,
                        height: 90,
                        child: Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  AppBottomSheet.display(
                                    context: context,
                                    widget: CartPageConfirmRemoveProduct(productOrderedEntity: productOrderedEntity),
                                    height: 200,
                                  );
                                },
                                backgroundColor: const Color(0xff382931),
                                foregroundColor: AppColors.removeColor,
                                icon: Icons.delete,
                              ),
                            ],
                          ),
                          child: CartPageProductOrderedItem(productOrderedEntity: productOrderedEntity,),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: products.length,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                CartPageSubTotal(subTotal: subTotal),
                const SizedBox(
                  height: 32,
                ),
                AppButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage(subTotal: subTotal, productsOrdered: products,)));
                  },
                  title: 'Go to checkout',
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          );
        }
        return Container();
      }),
    );
  }

  Widget _emptyCart(BuildContext context){
    return const Center(
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.subtextColor,
              size: 92,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Your Cart Is Empty!',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'When you add products, they’ll appear here..',
              style: TextStyle(
                color: AppColors.subtextColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
