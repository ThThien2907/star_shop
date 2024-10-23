import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/utils/bloc/button/button_cubit.dart';
import 'package:star_shop/utils/widgets/button/reactive_button.dart';

class CreateNewPasswordPage extends StatelessWidget {
  const CreateNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Password',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: BlocProvider(
        create: (context) => ButtonCubit(),
        child: Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              _newPasswordField(),
              SizedBox(
                height: 16,
              ),
              _confirmPasswordField(),
              SizedBox(
                height: 48,
              ),
              _updatePasswordButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newPasswordField() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'New Password',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter your new Password',
          ),
        ),
      ],
    );
  }

  Widget _confirmPasswordField() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Password',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter your confirm Password',
          ),
        ),
      ],
    );
  }

  Widget _updatePasswordButton(BuildContext context) {
    return Builder(builder: (context) {
      return ReactiveButton(
        onPressed: () {
          //context.read<ButtonCubit>().execute();
        },
        title: 'Update Password',
      );
    });
  }
}
