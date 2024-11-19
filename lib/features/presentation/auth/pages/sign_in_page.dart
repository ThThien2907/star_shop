import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/bottom_nav/app_bottom_nav.dart';
import 'package:star_shop/common/widgets/snack_bar/app_snack_bar.dart';
import 'package:star_shop/configs/assets/app_vectors.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/data/auth/models/user_sign_in_req.dart';
import 'package:star_shop/features/domain/auth/use_cases/sign_in_use_case.dart';
import 'package:star_shop/features/presentation/auth/pages/forget_password_page.dart';
import 'package:star_shop/features/presentation/auth/pages/sign_up_page.dart';
import 'package:star_shop/features/presentation/auth/widgets/email_text_field.dart';
import 'package:star_shop/features/presentation/auth/widgets/password_text_field.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BasicAppBar(
        title: 'Login to STARSHOP'
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ButtonCubit()),
        ],
        child: BlocListener<ButtonCubit, ButtonState>(
          listener: (context, state)  {
            if (state is ButtonSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AppBottomNav()),
              );
            }
            if (state is ButtonFailureState) {
              if (state.errorCode == 'too-many-requests') {
                AppSnackBar.showAppSnackBar(
                  context: context,
                  title:
                  'Too many requests, please try again later.',
                );
              }
              else if (state.errorCode == 'network-request-failed') {
                AppSnackBar.showAppSnackBar(
                  context: context,
                  title:
                  'Lost network connection, please check your network connection again',
                );
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                EmailTextField(emailController: _emailController),
                const SizedBox(
                  height: 12,
                ),
                PasswordTextField(
                  passwordController: _passwordController,
                ),
                const SizedBox(
                  height: 12,
                ),
                _forgotPassword(context),
                const SizedBox(
                  height: 34,
                ),
                _signInButton(context),
                const SizedBox(
                  height: 16,
                ),
                _divider(),
                const SizedBox(
                  height: 16,
                ),
                _signInWithGoogle(context),
                const SizedBox(
                  height: 16,
                ),
                _signInWithApple(context),
                const Spacer(),
                _signUpText(context),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgetPasswordPage()));
          },
          child: const Text(
            'Forgot Password',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _signInButton(BuildContext context) {
    return Builder(builder: (context) {
      return ReactiveButton(
        onPressed: () {
          context.read<ButtonCubit>().execute(
                useCase: SignInUseCase(),
                params: UserSignInReq(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                ),
              );
        },
        title: 'Login with Email',
      );
    });
  }

  Widget _divider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.grey,
            thickness: 2,
            endIndent: 10,
          ),
        ),
        Text(
          "Or",
          style: TextStyle(color: AppColors.grey, fontSize: 18),
        ),
        Expanded(
          child: Divider(
            color: AppColors.grey,
            thickness: 2,
            indent: 10,
          ),
        ),
      ],
    );
  }

  Widget _signInWithGoogle(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width, 50),
        side: const BorderSide(color: AppColors.primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppVectors.googleIcon),
          const SizedBox(
            width: 8,
          ),
          const Text(
            'Login with Google',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signInWithApple(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width, 50),
        side: const BorderSide(color: AppColors.primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppVectors.appleIcon),
          const SizedBox(
            width: 8,
          ),
          const Text(
            'Login with Apple',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don’t have any account yet?',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: const Text(
            'Register',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
