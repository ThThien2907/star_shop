import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/constant/app_const.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';
import 'package:star_shop/common/widgets/snack_bar/app_snack_bar.dart';
import 'package:star_shop/features/domain/auth/entities/user_address_entity.dart';
import 'package:star_shop/features/domain/order/entities/order_entity.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';
import 'package:star_shop/features/domain/order/use_cases/place_order_use_case.dart';
import 'package:star_shop/features/presentation/address/bloc/address_display_cubit.dart';
import 'package:star_shop/features/presentation/cart/bloc/cart_display_cubit.dart';
import 'package:star_shop/features/presentation/checkout/widgets/checkout_page_delivery_address.dart';
import 'package:star_shop/features/presentation/checkout/widgets/checkout_page_order_summary.dart';
import 'package:star_shop/features/presentation/checkout/widgets/checkout_page_payment_method.dart';
import 'package:star_shop/features/presentation/order/pages/order_page.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.subTotal, required this.productsOrdered});

  final num subTotal;
  final List<ProductOrderedEntity> productsOrdered;

  @override
  Widget build(BuildContext context) {
    num deliveryFee = 20;
    num total = subTotal + deliveryFee;
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'Checkout',
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ButtonCubit(),
        child: BlocListener<ButtonCubit, ButtonState>(
          listener: (context, state) {
            if(state is ButtonFailureState){
              AppSnackBar.showAppSnackBarFailure(context: context, title: 'Place order failure');
            }

            if(state is ButtonSuccessState){
              context.read<CartDisplayCubit>().getProductsFromCart();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OrderPage()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckoutPageDeliveryAddress(),
                      SizedBox(
                        height: 16,
                      ),
                      CheckoutPagePaymentMethod(),
                    ],
                  ),
                ),
                CheckoutPageOrderSummary(
                  subTotal: subTotal,
                  total: total,
                ),
                const SizedBox(
                  height: 32,
                ),
                Builder(builder: (context) {
                  return ReactiveButton(
                    onPressed: () {
                      UserAddressEntity userAddress = context.read<AddressDisplayCubit>().listAddress[context.read<AddressDisplayCubit>().defaultAddress];

                      OrderEntity orderEntity = OrderEntity(
                        orderID: AppConst.generateRandomString(20),
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        status: 'Pending',
                        totalPrice: total,
                        deliveryFee: deliveryFee,
                        productsOrdered: productsOrdered,
                        detailedAddress: userAddress.detailedAddress!,
                        ward: userAddress.ward!,
                        district: userAddress.district!,
                        city: userAddress.city!,
                        cityCode: userAddress.cityCode!,
                        districtCode: userAddress.districtCode!,
                      );

                      context.read<ButtonCubit>().execute(useCase: PlaceOrderUseCase(), params: orderEntity);
                    },
                    title: 'Place Order',
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
