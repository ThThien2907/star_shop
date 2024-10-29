import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/utils/bloc/button/button_cubit.dart';
import 'package:star_shop/utils/bloc/button/button_state.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  String emailErrorText = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
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
              if (widget.emailController.text.isEmpty) {
                emailErrorText = 'Email is required';
              }
              else if (state.errorCode == 'invalid-email') {
                emailErrorText = 'Invalid email';
              }
              else if (state.errorCode == 'email-already-in-use') {
                emailErrorText = 'Email already in use';
              }
              else {
                emailErrorText = '';
              }
            }
            return TextField(
              controller: widget.emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                errorText: emailErrorText.isEmpty ? null : emailErrorText,
              ),
            );
          },
        ),
      ],
    );
  }
}
