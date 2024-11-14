import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/data/auth/models/user_sign_up_req.dart';
import 'package:star_shop/features/domain/auth/use_cases/sign_up_use_case.dart';
import 'package:star_shop/features/presentation/auth/pages/sign_in_page.dart';
import 'package:star_shop/features/presentation/auth/pages/update_profile_page.dart';
import 'package:star_shop/features/presentation/auth/widgets/confirm_password_text_field.dart';
import 'package:star_shop/features/presentation/auth/widgets/email_text_field.dart';
import 'package:star_shop/features/presentation/auth/widgets/password_text_field.dart';
import 'package:star_shop/features/presentation/home/pages/home_page.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BasicAppBar(
        title: 'Register to STARSHOP'
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ButtonCubit()),
        ],
        child: BlocListener<ButtonCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdateProfilePage()),
                  (Route<dynamic> route) => false);
            }
            if (state is ButtonFailureState) {
              if (state.errorCode == 'too-many-requests'){
                //show snackbar
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
                //_emailField(),
                EmailTextField(emailController: _emailController),
                const SizedBox(
                  height: 16,
                ),
                //_passwordField(),
                PasswordTextField(
                  passwordController: _passwordController,
                ),
                const SizedBox(
                  height: 16,
                ),
                //_confirmPasswordField(),
                ConfirmPasswordTextField(
                  passwordController: _confirmPasswordController,
                ),
                const SizedBox(
                  height: 34,
                ),
                _signUpButton(context),
                const Spacer(),
                _signInText(context),
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

  Widget _signUpButton(BuildContext context) {
    return Builder(builder: (context) {
      return ReactiveButton(
        onPressed: () {
            context.read<ButtonCubit>().execute(
              useCase: SignUpUseCase(),
              params: UserSignUpReq(
                  email: _emailController.text,
                  password: _passwordController.text,
                  confirmPassword: _confirmPasswordController.text,
              ),
            );
        },
        title: 'Register with Email',
      );
    });
  }

  Widget _signInText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
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
                context, MaterialPageRoute(builder: (context) => SignInPage()));
          },
          child: const Text(
            'Login',
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
