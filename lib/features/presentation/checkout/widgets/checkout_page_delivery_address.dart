import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/auth/entities/user_address_entity.dart';
import 'package:star_shop/features/presentation/address/bloc/address_display_cubit.dart';
import 'package:star_shop/features/presentation/address/bloc/address_display_state.dart';
import 'package:star_shop/features/presentation/address/pages/address_page.dart';

class CheckoutPageDeliveryAddress extends StatelessWidget {
  const CheckoutPageDeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(
                  fontSize: 16, color: AppColors.primaryTextColor),
            ),
            const Spacer(),
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressPage()));
              },
              child: const Text(
                'Change',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.subtextColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.subtextColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16,),

        BlocBuilder<AddressDisplayCubit, AddressDisplayState>(
            builder: (context, state) {
              if (state is AddressDisplayInitialState) {
                context.read<AddressDisplayCubit>().getAddress();
              }

              if (state is AddressDisplayLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (state is AddressDisplayLoadFailure) {
                return Center(
                  child: AppErrorWidget(
                    onPress: () {
                      context.read<AddressDisplayCubit>().getAddress();
                    },
                  ),
                );
              }

              if(state is AddressDisplayLoaded){
                UserAddressEntity userAddressEntity = state.list.firstWhere((e) => e.isDefault == true);
                return Row(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _addressName(context, userAddressEntity.addressName!),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          _addressDetail(context, userAddressEntity),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Container();
            }
        ),
      ],
    );
  }

  Widget _addressName(BuildContext context, String addressName){
    return Text(
      addressName,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.textColor,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 1,
    );
  }

  Widget _addressDetail(BuildContext context, UserAddressEntity userAddressEntity) {
    return SizedBox(
      height: 50,
      child: Text(
        '${userAddressEntity.detailedAddress}, ${userAddressEntity.ward}, ${userAddressEntity.district}, ${userAddressEntity.city}',
        style:
        const TextStyle(fontSize: 16, color: AppColors.subtextColor),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
