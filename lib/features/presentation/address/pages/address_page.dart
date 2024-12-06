import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/button/app_button.dart';
import 'package:star_shop/common/widgets/button/app_button_outline.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/auth/entities/user_address_entity.dart';
import 'package:star_shop/features/presentation/address/bloc/address_display_cubit.dart';
import 'package:star_shop/features/presentation/address/bloc/address_display_state.dart';
import 'package:star_shop/features/presentation/address/bloc/address_item_selection_cubit.dart';
import 'package:star_shop/features/presentation/address/widgets/address_page_item.dart';
import 'package:star_shop/features/presentation/address/widgets/address_page_title.dart';
import 'package:star_shop/features/presentation/auth/pages/add_or_update_address_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  bool isEditAddress = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'My Address',
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AddressItemSelectionCubit()),
        ],
        child: BlocBuilder<AddressDisplayCubit, AddressDisplayState>(
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

            if (state is AddressDisplayLoaded) {
              List<UserAddressEntity> listAddress = state.list;
              context.read<AddressItemSelectionCubit>().itemSelection(
                  context.watch<AddressDisplayCubit>().defaultAddress);
              return SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    AddressPageTitle(
                      isEditAddress: isEditAddress,
                      onPressed: () {
                        setState(() {
                          isEditAddress = !isEditAddress;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AddressPageItem(
                          userAddressEntity: listAddress[index],
                          index: index,
                          isEditAddress: isEditAddress,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16,
                        );
                      },
                      itemCount: listAddress.length,
                      // itemCount: 4,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    AppButtonOutline(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddOrUpdateAddressPage()));
                      },
                      widget: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.textColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Add New Address',
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BlocBuilder<AddressItemSelectionCubit, int>(
                      builder: (context, state) {
                        return AppButton(
                          onPressed: !isEditAddress
                              ? () {
                                  String addressId =
                                      listAddress[state].addressId!;
                                  context
                                      .read<AddressDisplayCubit>()
                                      .setDefaultAddress(addressId);
                                }
                              : () {
                                  setState(() {
                                    isEditAddress = !isEditAddress;
                                  });
                                },
                          title: !isEditAddress ? 'Apply' : 'Finish',
                        );
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
