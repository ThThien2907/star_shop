import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/presentation/auth/bloc/verify_email_cubit.dart';
import 'package:star_shop/features/presentation/auth/bloc/verify_email_state.dart';
import 'package:star_shop/features/presentation/auth/pages/update_profile_page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  int seconds = 60;
  bool canResend = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          seconds--;
          if(seconds < 0){
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
      body: BlocProvider(
        create: (context) => VerifyEmailCubit()..sendEmailToVerifyEmail(),
        child: BlocListener<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifiedState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdateProfilePage()));
            }
            if (state is NotVerifiedState) {}
          },
          child: Container(
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
                  'A verification email has been sent to your email',
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
                      seconds == 0 ? '' : seconds.toString(),
                      style: const TextStyle(
                          color: AppColors.subtextColor,
                          fontSize: 16,
                          decorationColor: AppColors.subtextColor),
                    ),

                    const SizedBox(width: 2,),

                    Builder(
                      builder: (context) {
                        return TextButton(
                          onPressed: canResend ? () {
                            context.read<VerifyEmailCubit>().sendEmailToVerifyEmail();
                            canResend = false;
                            seconds = 60;
                            startTimer();
                          } : null,
                          child: Text(
                            'Resend email',
                            style: TextStyle(
                                color: canResend ? AppColors.primaryColor : AppColors.subtextColor,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: canResend ? AppColors.primaryColor : AppColors.subtextColor,),
                          ),
                        );
                      }
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
