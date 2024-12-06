import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_cubit.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/button/app_button.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/presentation/auth/pages/add_or_update_profile_page.dart';
import 'package:star_shop/features/presentation/profile/widgets/profile_page_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'My Profile',
        centerTitle: true,
      ),
      body: BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
        builder: (context, state) {
          if (state is UserInfoLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (state is UserInfoLoadFailure) {
            return Center(
              child: AppErrorWidget(
                onPress: () {
                  context.read<UserInfoDisplayCubit>().getUser();
                },
              ),
            );
          }

          if (state is UserInfoLoaded) {
            UserEntity userEntity = state.userEntity;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  ProfilePageItem(
                    title: 'Full Name',
                    value: userEntity.fullName,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ProfilePageItem(
                    title: 'Email Address',
                    value: userEntity.email,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ProfilePageItem(
                    title: 'Date of Birth',
                    value: userEntity.dob,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ProfilePageItem(
                    title: 'Gender',
                    value: userEntity.gender,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ProfilePageItem(
                    title: 'Phone Number',
                    value: userEntity.phoneNumber,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  AppButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddOrUpdateProfilePage(
                            isUpdateProfile: true,
                            fullName: userEntity.fullName,
                            dob: userEntity.dob,
                            phoneNumber: userEntity.phoneNumber,
                            gender: userEntity.gender,
                          ),
                        ),
                      );
                    },
                    title: 'Edit My Profile',
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
