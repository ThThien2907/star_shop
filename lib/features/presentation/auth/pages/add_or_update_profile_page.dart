import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_cubit.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';
import 'package:star_shop/common/widgets/input_field/app_text_field.dart';
import 'package:star_shop/common/widgets/snack_bar/app_snack_bar.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/domain/auth/use_cases/add_or_update_profile_use_case.dart';
import 'package:star_shop/features/presentation/auth/pages/add_or_update_address_page.dart';

class AddOrUpdateProfilePage extends StatefulWidget {
  const AddOrUpdateProfilePage(
      {super.key, this.fullName, this.dob, this.phoneNumber, this.gender, required this.isUpdateProfile});

  final String? fullName;
  final String? dob;
  final String? phoneNumber;
  final String? gender;
  final bool isUpdateProfile;

  @override
  State<AddOrUpdateProfilePage> createState() => _AddOrUpdateProfilePageState();
}

class _AddOrUpdateProfilePageState extends State<AddOrUpdateProfilePage> {
  final TextEditingController dobController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  DateTime? pickedDate;
  DateTime? initialDate;

  DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    nameController.text = widget.fullName ?? '';
    dobController.text = widget.dob ?? '';
    phoneController.text = widget.phoneNumber ?? '';
    genderController.text = widget.gender ?? '';
    
    initialDate = widget.isUpdateProfile ? dateFormat.parse(widget.dob!) : DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BasicAppBar(title: widget.isUpdateProfile ? 'Update Profile' : 'New Profile', centerTitle: true,),
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
              if (!widget.isUpdateProfile) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddOrUpdateAddressPage(isFirstAddress: true,)),
                        (route) => false);
              }
              else {
                context.read<UserInfoDisplayCubit>().getUser();
                Navigator.pop(context);
              }
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
                const Spacer(),
                Builder(
                  builder: (context) {
                    return ReactiveButton(
                      title: widget.isUpdateProfile ? 'Save' : 'Continue',
                      onPressed: () {
                        if (nameController.text.isEmpty ||
                            phoneController.text.isEmpty ||
                            dobController.text.isEmpty ||
                            genderController.text.isEmpty
                        ) {
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
                            gender: genderController.text.trim(),
                            role: 'UR',
                          );
                          context.read<ButtonCubit>().execute(
                              params: user,
                              useCase: AddOrUpdateProfileUseCase());
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
            dobController.text = dateFormat.format(pickedDate!);
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
}

class GenderDropdownButton extends StatefulWidget {
  const GenderDropdownButton({super.key, required this.genderController});

  final TextEditingController genderController;

  @override
  State<GenderDropdownButton> createState() => _GenderDropdownButtonState();
}

class _GenderDropdownButtonState extends State<GenderDropdownButton> {
  final List<String> genders = ['Male', 'Female', 'Other Gender'];
  late String initialGender;

  @override
  void initState() {
    super.initState();
    initialGender =
    widget.genderController.text.isEmpty ? genders[0] : widget.genderController
        .text;
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
        items: genders.map((value) {
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
