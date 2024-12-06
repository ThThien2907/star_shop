import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:star_shop/common/widgets/bottom_sheet/confirm_event_bottom_sheet.dart';
import 'package:star_shop/common/widgets/snack_bar/app_snack_bar.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/auth/entities/user_address_entity.dart';
import 'package:star_shop/features/presentation/address/bloc/address_display_cubit.dart';
import 'package:star_shop/features/presentation/address/bloc/address_item_selection_cubit.dart';
import 'package:star_shop/features/presentation/auth/pages/add_or_update_address_page.dart';

class AddressPageItem extends StatelessWidget {
  const AddressPageItem(
      {super.key,
      required this.userAddressEntity,
      required this.index,
      required this.isEditAddress});

  final UserAddressEntity userAddressEntity;
  final int index;
  final bool isEditAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    Expanded(
                      child: Text(
                        userAddressEntity.addressName!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.textColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      userAddressEntity.isDefault! ? 'Default' : '',
                      style: const TextStyle(
                          fontSize: 16, color: AppColors.primaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 50,
                  child: Text(
                    '${userAddressEntity.detailedAddress}, ${userAddressEntity.ward}, ${userAddressEntity.district}, ${userAddressEntity.city},',
                    style:
                        const TextStyle(fontSize: 16, color: AppColors.subtextColor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          if (isEditAddress)
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddOrUpdateAddressPage(
                                  userAddressEntity: userAddressEntity,
                                  isUpdate: true,
                                )));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.grey,
                  ),
                  iconSize: 22,
                ),
                IconButton(
                  onPressed: () {
                    AppBottomSheet.display(
                      context: context,
                      widget: ConfirmEventBottomSheet(
                          title: 'Delete Address',
                          subtitle:
                              'Are you sure you want to delete this address?',
                          confirmText: 'Yes, Delete',
                          onPressedCancelButton: () {
                            Navigator.pop(context);
                          },
                          onPressedYesButton: () async {
                            var response = await context
                                .read<AddressDisplayCubit>()
                                .removeAddress(userAddressEntity);
                            if (response) {
                              AppSnackBar.showAppSnackBarSuccess(
                                  context: context,
                                  title: 'Delete address successful!');
                            } else {
                              AppSnackBar.showAppSnackBarFailure(
                                  context: context,
                                  title: 'Can not delete default address!');
                            }
                            Navigator.pop(context);
                          }),
                      height: 250,
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.removeColor,
                  ),
                  iconSize: 22,
                ),
              ],
            ),
          if (!isEditAddress)
            BlocBuilder<AddressItemSelectionCubit, int>(
                builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context
                      .read<AddressItemSelectionCubit>()
                      .itemSelection(index);
                },
                icon: Icon(
                  state == index
                      ? Icons.radio_button_on
                      : Icons.radio_button_off,
                  color: state == index ? AppColors.black100 : AppColors.grey,
                ),
              );
            }),
          const SizedBox(
            width: 6,
          ),
        ],
      ),
    );
  }
}
