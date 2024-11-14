import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  String passwordErrorText = '';
  bool isHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
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
                passwordErrorText = 'Password is required';
              } else if (state.errorCode == 'invalid-credential') {
                passwordErrorText = 'Wrong password provided for this user';
              } else if (state.errorCode == 'weak-password') {
                passwordErrorText = 'Password is too weak';
              } else {
                passwordErrorText = '';
              }
            }

            return TextField(
              controller: widget.passwordController,
              obscureText: isHidePassword,
              decoration: InputDecoration(
                hintText: 'Enter your password',
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
