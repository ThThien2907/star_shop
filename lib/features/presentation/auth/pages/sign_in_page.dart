import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_shop/configs/assets/app_vectors.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/presentation/auth/pages/sign_up_page.dart';
import 'package:star_shop/utils/bloc/button/button_cubit.dart';
import 'package:star_shop/utils/widgets/button/reactive_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login to STARSHOP',
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
          padding: const EdgeInsets.all(16),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              _emailField(),
              const SizedBox(
                height: 16,
              ),
              _passwordField(),
              const SizedBox(
                height: 16,
              ),
              _forgotPassword(context),
              const SizedBox(
                height: 48,
              ),
              _signInButton(context),
              const SizedBox(
                height: 48,
              ),
              _divider(),
              const SizedBox(
                height: 48,
              ),
              _signInWithGoogle(context),
              const SizedBox(
                height: 16,
              ),
              _signInWithApple(context),
              const Spacer(),
              _signUpText(context),
              const SizedBox(
                height: 50,
              ),
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

  Widget _passwordField() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
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
            hintText: 'Enter your password',
          ),
        ),
      ],
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {},
          child: const Text(
            'Forgot Password',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 18,
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
          context.read<ButtonCubit>().execute();
        },
        title: 'Login with Email',
      );
    });
  }

  Widget _divider(){
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

  Widget _signInWithGoogle(BuildContext context){
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width, 60),
        side:
        const BorderSide(color: AppColors.primaryColor, width: 2),
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
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signInWithApple(BuildContext context){
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width, 60),
        side:
        const BorderSide(color: AppColors.primaryColor, width: 2),
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
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpText(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don’t have any account yet?',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignUpPage()));
          },
          child: const Text(
            'Register',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
            ),
          ),
        )
      ],
    );
  }
}
