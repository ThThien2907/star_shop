import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/presentation/auth/bloc/password_cubit.dart';
import 'package:star_shop/features/presentation/auth/bloc/password_state.dart';
import 'package:star_shop/utils/bloc/button/button_cubit.dart';
import 'package:star_shop/utils/bloc/button/button_state.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  const ConfirmPasswordTextField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  State<ConfirmPasswordTextField> createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  String passwordErrorText = '';
  bool isHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordCubit(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Confirm Password',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          BlocBuilder<ButtonCubit, ButtonState>(
            builder: (context, state) {
              if (state is ButtonFailureState) {
                if (widget.passwordController.text.isEmpty ||
                    state.errorCode == 'missing-password') {
                  passwordErrorText = 'Confirm Password is required';
                } else if (state.errorCode == 'password-not-match') {
                  passwordErrorText = 'Passwords do not match';
                } else {
                  passwordErrorText = '';
                }
              }
              return BlocBuilder<PasswordCubit, PasswordState>(
                builder: (context, state1) {
                  if (state1 is PasswordHideState) {
                    isHidePassword = true;
                  }
                  if (state1 is PasswordShowState) {
                    isHidePassword = false;
                  }
                  return TextField(
                    controller: widget.passwordController,
                    obscureText: isHidePassword,
                    decoration: InputDecoration(
                      hintText: 'Enter your confirm password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          context.read<PasswordCubit>().changePasswordToggle(isHidePassword);
                        },
                        icon: isHidePassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      errorText:
                          passwordErrorText.isEmpty ? null : passwordErrorText,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
