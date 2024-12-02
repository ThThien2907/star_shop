import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/widgets/button/app_button.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';
import 'package:star_shop/features/presentation/cart/bloc/cart_display_cubit.dart';

class CartPageConfirmRemoveProduct extends StatelessWidget {
  const CartPageConfirmRemoveProduct({super.key, required this.productOrderedEntity});

  final ProductOrderedEntity productOrderedEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Are you want to delete this product?',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.textColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        Row(
          children: [
            Expanded(
              child: Builder(builder: (context) {
                return AppButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  title: 'Cancel',
                  color: AppColors.cancelColor,
                  height: 60,
                );
              }),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Builder(builder: (context) {
                return AppButton(
                  onPressed: () async {
                    context
                        .read<CartDisplayCubit>()
                        .removeProductFromCart(productOrderedEntity.productID);
                    Navigator.pop(context);
                  },
                  title: 'Yes, Remove',
                  height: 60,
                  color: AppColors.removeColor,
                );
              }),
            ),
          ],
        )
      ],
    );
  }
}
