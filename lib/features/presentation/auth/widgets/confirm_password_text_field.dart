import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';

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
    return Column(
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
          height: 6,
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

                return TextField(
                  controller: widget.passwordController,
                  obscureText: isHidePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter your confirm password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isHidePassword = !isHidePassword;
                        });
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
        ),
      ],
    );
  }
}
