import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';
import 'package:star_shop/common/widgets/input_field/app_text_field.dart';
import 'package:star_shop/common/widgets/snack_bar/app_snack_bar.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/domain/auth/use_cases/update_profile_use_case.dart';
import 'package:star_shop/features/presentation/auth/pages/update_address_page.dart';

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
      appBar: const BasicAppBar(title: 'Update Your Profile', centerTitle: true,),
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
                  MaterialPageRoute(builder: (context) => const UpdateAddressPage()),
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
                const Spacer(),
                Builder(
                  builder: (context) {
                    return ReactiveButton(
                      title: 'Finish',
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
