import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/bloc/location/district/district_display_cubit.dart';
import 'package:star_shop/common/bloc/location/district/district_display_state.dart';
import 'package:star_shop/common/bloc/location/province/province_display_cubit.dart';
import 'package:star_shop/common/bloc/location/province/province_display_state.dart';
import 'package:star_shop/common/bloc/location/ward/ward_display_cubit.dart';
import 'package:star_shop/common/bloc/location/ward/ward_display_state.dart';
import 'package:star_shop/common/constant/app_const.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/bottom_nav/app_bottom_nav.dart';
import 'package:star_shop/common/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';
import 'package:star_shop/common/widgets/input_field/app_text_field.dart';
import 'package:star_shop/common/widgets/snack_bar/app_snack_bar.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/auth/entities/user_address_entity.dart';
import 'package:star_shop/features/domain/auth/use_cases/add_address_use_case.dart';
import 'package:star_shop/features/domain/location/entities/district_entity.dart';
import 'package:star_shop/features/domain/location/entities/province_entity.dart';
import 'package:star_shop/features/domain/location/entities/ward_entity.dart';

class UpdateAddressPage extends StatefulWidget {
  const UpdateAddressPage({super.key});

  @override
  State<UpdateAddressPage> createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {

  final TextEditingController addressNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController wardController = TextEditingController();

  String provinceCode = '';
  String districtCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BasicAppBar(title: 'Update Your Address', centerTitle: true,),
      body: BlocProvider(
        create: (context) => ButtonCubit(),
        child: BlocListener<ButtonCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              var snackBar = SnackBar(
                content: Text(
                  state.errorCode,
                  style:
                  const TextStyle(color: AppColors.textColor, fontSize: 16),
                ),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (state is ButtonSuccessState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AppBottomNav()),
                      (route) => false);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  title: 'Address Name',
                  hintText: 'Home, Company...',
                  controller: addressNameController,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Flexible(
                        child: AppTextField(
                          title: 'Address',
                          hintText: 'Enter your Address',
                          controller: addressController,
                        )),
                    const SizedBox(
                      width: 12,
                    ),
                    _provinceField(context),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    _districtField(context),
                    const SizedBox(
                      width: 12,
                    ),
                    _wardField(context),
                  ],
                ),
                const Spacer(),
                Builder(
                  builder: (context) {
                    return ReactiveButton(
                      title: 'Finish',
                      onPressed: () {
                        if (addressController.text.isEmpty ||
                            provinceController.text.isEmpty ||
                            districtController.text.isEmpty ||
                            wardController.text.isEmpty) {
                          AppSnackBar.showAppSnackBar(
                            context: context,
                            title: 'Please fill in all fields.',
                          );
                        } else {
                          UserAddressEntity userAddress = UserAddressEntity(
                            addressId: AppConst.generateRandomString(20),
                            addressName: 'Home',
                            detailedAddress: addressController.text.trim(),
                            city: provinceController.text.trim(),
                            district: districtController.text.trim(),
                            ward: wardController.text.trim(),
                            isDefault: true,
                          );
                          context.read<ButtonCubit>().execute(
                              params: userAddress, useCase: AddAddressUseCase());
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _provinceField(BuildContext context) {
    return Flexible(
      child: AppTextField(
        title: 'City/Province',
        hintText: 'Select your City/Province',
        controller: provinceController,
        readOnly: true,
        suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.textColor,
        ),
        onTap: () {
          AppBottomSheet.display(
            context: context,
            widget: BlocProvider(
              create: (context) => ProvinceDisplayCubit()..getAllProvinces(),
              child: BlocBuilder<ProvinceDisplayCubit, ProvinceDisplayState>(
                builder: (context, state) {
                  if (state is ProvinceLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProvinceLoadFailure) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<ProvinceDisplayCubit>()
                              .getAllProvinces();
                        },
                        child: const Text('Try again'),
                      ),
                    );
                  }
                  if (state is ProvinceLoaded) {
                    List<ProvinceEntity> provinces = state.provinces;
                    return Column(
                      children: [
                        const Text(
                          'Select your Province',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.grey,
                          thickness: 2,
                        ),
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  provinceController.text =
                                      provinces[index].name_with_type;
                                  provinceCode = provinces[index].code;
                                  districtCode = '';
                                  districtController.text = '';
                                  wardController.text = '';
                                  Navigator.pop(context);
                                },
                                title: Text(provinces[index].name_with_type),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 1,
                                color: AppColors.grey,
                                thickness: 0.5,
                                indent: 10,
                                endIndent: 10,
                              );
                            },
                            itemCount: provinces.length,
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _districtField(BuildContext context) {
    return Flexible(
      child: AppTextField(
        title: 'District',
        hintText: 'Select your District',
        controller: districtController,
        readOnly: true,
        suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.textColor,
        ),
        onTap: () {
          if (provinceCode.isNotEmpty) {
            AppBottomSheet.display(
              context: context,
              widget: BlocProvider(
                create: (context) =>
                DistrictDisplayCubit()..getDistrictByProvince(provinceCode),
                child: BlocBuilder<DistrictDisplayCubit, DistrictDisplayState>(
                  builder: (context, state) {
                    if (state is DistrictLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is DistrictLoadFailure) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<DistrictDisplayCubit>()
                                .getDistrictByProvince(provinceCode);
                          },
                          child: const Text('Try again'),
                        ),
                      );
                    }
                    if (state is DistrictLoaded) {
                      List<DistrictEntity> districts = state.districts;
                      return Column(
                        children: [
                          const Text(
                            'Select your Province',
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Divider(
                            height: 1,
                            color: AppColors.grey,
                            thickness: 2,
                          ),
                          Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    districtController.text =
                                        districts[index].name_with_type;
                                    districtCode = districts[index].code;
                                    wardController.text = '';
                                    Navigator.pop(context);
                                  },
                                  title: Text(districts[index].name_with_type),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  height: 1,
                                  color: AppColors.grey,
                                  thickness: 0.5,
                                  indent: 10,
                                  endIndent: 10,
                                );
                              },
                              itemCount: districts.length,
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            );
          } else {
            AppSnackBar.showAppSnackBar(
              context: context,
              title: 'Please select your city.',
            );
          }
        },
      ),
    );
  }

  Widget _wardField(BuildContext context) {
    return Flexible(
      child: AppTextField(
        title: 'Ward',
        hintText: 'Select your Ward',
        controller: wardController,
        readOnly: true,
        suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.textColor,
        ),
        onTap: () {
          if (districtCode.isNotEmpty) {
            AppBottomSheet.display(
              context: context,
              widget: BlocProvider(
                create: (context) =>
                WardDisplayCubit()..getWardByDistrict(districtCode),
                child: BlocBuilder<WardDisplayCubit, WardDisplayState>(
                  builder: (context, state) {
                    if (state is WardLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is WardLoadFailure) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<WardDisplayCubit>()
                                .getWardByDistrict(districtCode);
                          },
                          child: const Text('Try again'),
                        ),
                      );
                    }
                    if (state is WardLoaded) {
                      List<WardEntity> wards = state.wards;
                      return Column(
                        children: [
                          const Text(
                            'Select your Ward',
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Divider(
                            height: 1,
                            color: AppColors.grey,
                            thickness: 2,
                          ),
                          Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    wardController.text =
                                        wards[index].name_with_type;
                                    Navigator.pop(context);
                                  },
                                  title: Text(wards[index].name_with_type),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  height: 1,
                                  color: AppColors.grey,
                                  thickness: 0.5,
                                  indent: 10,
                                  endIndent: 10,
                                );
                              },
                              itemCount: wards.length,
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            );
          } else {
            var snackBar = const SnackBar(
              content: Text(
                'Please select your district.',
                style: TextStyle(color: AppColors.textColor, fontSize: 16),
              ),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            AppSnackBar.showAppSnackBar(
              context: context,
              title: 'Please select your district.',
            );
          }
        },
      ),
    );
  }
}
