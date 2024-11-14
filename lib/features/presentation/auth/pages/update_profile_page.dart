import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/bloc/location/district/district_display_state.dart';
import 'package:star_shop/common/bloc/location/province/province_display_state.dart';
import 'package:star_shop/common/bloc/location/ward/ward_display_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/bottom_nav/app_bottom_nav.dart';
import 'package:star_shop/common/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';
import 'package:star_shop/common/widgets/input_field/app_text_field.dart';
import 'package:star_shop/common/widgets/snack_bar/app_snack_bar.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/domain/auth/use_cases/update_profile_use_case.dart';
import 'package:star_shop/features/domain/location/entities/district_entity.dart';
import 'package:star_shop/features/domain/location/entities/province_entity.dart';
import 'package:star_shop/features/domain/location/entities/ward_entity.dart';
import 'package:star_shop/common/bloc/location/district/district_display_cubit.dart';
import 'package:star_shop/common/bloc/location/province/province_display_cubit.dart';
import 'package:star_shop/common/bloc/location/ward/ward_display_cubit.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController dobController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController wardController = TextEditingController();

  String provinceCode = '';
  String districtCode = '';

  DateTime? pickedDate;
  DateTime? initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BasicAppBar(
        title: 'Update Your Profile'
      ),
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
                  title: 'Full Name',
                  hintText: 'Enter your Full Name',
                  controller: nameController,
                ),
                const SizedBox(
                  height: 12,
                ),
                AppTextField(
                  title: 'Phone Number',
                  hintText: '0xxxxxxxxx',
                  controller: phoneController,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    _dateOfBirthField(context),
                    const SizedBox(
                      width: 12,
                    ),
                    _genderField(context),
                  ],
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
                        if (nameController.text.isEmpty ||
                            phoneController.text.isEmpty ||
                            dobController.text.isEmpty ||
                            genderController.text.isEmpty ||
                            addressController.text.isEmpty ||
                            cityController.text.isEmpty ||
                            districtController.text.isEmpty ||
                            wardController.text.isEmpty) {
                          AppSnackBar.showAppSnackBar(
                            context: context,
                            title: 'Please fill in all fields.',
                          );
                        } else {
                          UserEntity user = UserEntity(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            fullName: nameController.text.trim(),
                            email: FirebaseAuth.instance.currentUser!.email!,
                            dob: dobController.text.trim(),
                            phoneNumber: phoneController.text.trim(),
                            address: addressController.text.trim(),
                            city: cityController.text.trim(),
                            district: districtController.text.trim(),
                            ward: wardController.text.trim(),
                            gender: genderController.text.trim(),
                            role: 'UR',
                          );
                          context.read<ButtonCubit>().execute(
                              params: user, useCase: UpdateProfileUseCase());
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

  Widget _dateOfBirthField(BuildContext context) {
    return Flexible(
      child: AppTextField(
        title: 'Date Of Birth',
        hintText: 'dd/MM/yyyy',
        controller: dobController,
        suffixIcon: const Icon(
          Icons.date_range,
          color: AppColors.textColor,
        ),
        readOnly: true,
        onTap: () async {
          pickedDate = await showDatePicker(
            context: context,
            firstDate: DateTime(1960),
            lastDate: DateTime.now(),
            initialDate: initialDate,
          );

          if (pickedDate != null && pickedDate != initialDate) {
            initialDate = pickedDate;
            dobController.text =
                '${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}';
          }
        },
      ),
    );
  }

  Widget _genderField(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gender',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          GenderDropdownButton(genderController: genderController),
        ],
      ),
    );
  }

  Widget _provinceField(BuildContext context) {
    return Flexible(
      child: AppTextField(
        title: 'City/Province',
        hintText: 'Select your City/Province',
        controller: cityController,
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
                                  cityController.text =
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

class GenderDropdownButton extends StatefulWidget {
  const GenderDropdownButton({super.key, required this.genderController});

  final TextEditingController genderController;

  @override
  State<GenderDropdownButton> createState() => _GenderDropdownButtonState();
}

class _GenderDropdownButtonState extends State<GenderDropdownButton> {
  final List<String> gender = ['Male', 'Female', 'Other Gender'];
  late String initialGender;

  @override
  void initState() {
    super.initState();
    initialGender = gender[0];
    widget.genderController.text = initialGender;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff74717D), width: 1.5),
      ),
      child: DropdownButton(
        value: initialGender,
        items: gender.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            initialGender = value!;
            widget.genderController.text = initialGender;
          });
        },
        isExpanded: true,
        underline: Container(),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        dropdownColor: AppColors.black100,
      ),
    );
  }
}
