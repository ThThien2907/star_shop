import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/widgets/button/app_button.dart';
import 'package:star_shop/common/widgets/network_image/app_network_image.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';
import 'package:star_shop/features/presentation/cart/bloc/cart_display_cubit.dart';

class CartPageProductOrderedItem extends StatelessWidget {
  const CartPageProductOrderedItem(
      {super.key, required this.productOrderedEntity});

  final ProductOrderedEntity productOrderedEntity;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _productOrderedTitle(
                  context,
                  1,
                  TextOverflow.ellipsis,
                ),
                _productOrderedQuantity(
                  context,
                ),
                Row(
                  children: [
                    _productOrderedPrice(
                      context,
                    ),
                    const Spacer(),
                    _productOrderedEditButton(
                      context,
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      );
    });
  }

  Widget _productOrderedTitle(
      BuildContext context, int? maxLines, TextOverflow? textOverflow) {
    return Text(
      productOrderedEntity.title,
      style: const TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }

  Widget _productOrderedQuantity(BuildContext context) {
    return Text(
      'Quantity: ${productOrderedEntity.quantity}',
      style: const TextStyle(color: AppColors.subtextColor, fontSize: 16),
    );
  }

  Widget _productOrderedPrice(BuildContext context) {
    return Text(
      '\$${productOrderedEntity.totalPrice}',
      style: const TextStyle(color: AppColors.textColor, fontSize: 16),
    );
  }

  Widget _productOrderedEditButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        num quantity = productOrderedEntity.quantity;

        showModalBottomSheet(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setModelState) {
                return Container(
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, left: 16, right: 16),
                  width: double.infinity,
                  height: 280,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _productOrderedTitle(context, null, null),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _changeQuantityButton(
                            context,
                            onTap: () {
                              setModelState(() {
                                quantity--;
                              });
                            },
                            color: AppColors.black100,
                            icon: Icons.remove,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(
                                color: AppColors.textColor, fontSize: 20),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          _changeQuantityButton(
                            context,
                            onTap: () {
                              setModelState(() {
                                quantity++;
                              });
                            },
                            color: AppColors.primaryColor,
                            icon: Icons.add,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              title: 'Cancel',
                              color: AppColors.cancelColor,
                              height: 60,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Builder(builder: (context) {
                              return AppButton(
                                onPressed: () async {
                                  num totalPrice =
                                      quantity * productOrderedEntity.price;
                                  context
                                      .read<CartDisplayCubit>()
                                      .updateProductQuantity(
                                        productOrderedEntity.productID,
                                        quantity,
                                        totalPrice,
                                      );
                                  Navigator.pop(context);
                                },
                                title: 'Confirm',
                                height: 60,
                                color: AppColors.primaryColor,
                              );
                            }),
                          )
                        ],
                      )
                    ],
                  ),
                );
              });
            });
      },
      child: const Text(
        'Edit',
        style: TextStyle(
          color: AppColors.textColor,
          fontSize: 16,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.textColor,
        ),
      ),
    );
  }

  Widget _changeQuantityButton(BuildContext context,
      {required VoidCallback onTap,
      required Color color,
      required IconData icon}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppColors.textColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}
