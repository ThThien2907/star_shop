import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/button/app_button.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';
import 'package:star_shop/features/domain/auth/use_cases/send_password_reset_email_use_case.dart';
import 'package:star_shop/features/presentation/auth/widgets/email_text_field.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController emailController = TextEditingController();

  int seconds = 60;
  bool canResend = true;
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          seconds--;
          if (seconds < 0) {
            canResend = true;
            timer!.cancel();
          }
        });
      },
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: 'Forgot Password'),
      body: BlocProvider(
        create: (context) => ButtonCubit(),
        child: BlocBuilder<ButtonCubit, ButtonState>(
          builder: (context, state) {
            if (state is ButtonSuccessState) {
              return Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.mark_email_unread_outlined,
                      color: AppColors.textColor,
                      size: 200,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'An email has been sent your email, please check your email to reset password.',
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          seconds <= 0 ? '' : seconds.toString(),
                          style: const TextStyle(
                              color: AppColors.subtextColor,
                              fontSize: 16,
                              decorationColor: AppColors.subtextColor),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Builder(builder: (context) {
                          return TextButton(
                            onPressed: canResend
                                ? () {
                                    context.read<ButtonCubit>().execute(
                                          params: emailController.text.trim(),
                                          useCase:
                                              SendPasswordResetEmailUseCase(),
                                        );
                                    canResend = false;
                                    seconds = 60;
                                    startTimer();
                                  }
                                : null,
                            child: Text(
                              'Resend email',
                              style: TextStyle(
                                color: canResend
                                    ? AppColors.primaryColor
                                    : AppColors.subtextColor,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: canResend
                                    ? AppColors.primaryColor
                                    : AppColors.subtextColor,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      title: 'Back to login',
                    ),
                  ],
                ),
              );
            }

            if (state is ButtonFailureState) {
            }

            if (state is ButtonInitialState) {
              return Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Enter your email id for the verification process, we will send 4 digit to your email',
                      style: TextStyle(
                        color: AppColors.subtextColor,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // _emailField(),
                    EmailTextField(emailController: emailController),
                    const SizedBox(
                      height: 34,
                    ),
                    _continueButton(context),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(builder: (context) {
      return ReactiveButton(
        onPressed: () {
          context.read<ButtonCubit>().execute(
                params: emailController.text.trim(),
                useCase: SendPasswordResetEmailUseCase(),
              );
        },
        title: 'Continue',
      );
    });
  }
}
