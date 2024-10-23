import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/utils/bloc/button/button_cubit.dart';
import 'package:star_shop/utils/widgets/button/reactive_button.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
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
                height: 30,
              ),
              Text(
                'Enter your email id for the verification process, we will send 4 digit to your email',
                style: TextStyle(
                  color: AppColors.subtextColor,
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 50,
              ),
              _emailField(),
              SizedBox(
                height: 48,
              ),
              _continueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
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
            hintText: 'Enter your email',
          ),
        ),
      ],
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(builder: (context) {
      return ReactiveButton(
        onPressed: () {
          //context.read<ButtonCubit>().execute();
        },
        title: 'Continue',
      );
    });
  }
}
