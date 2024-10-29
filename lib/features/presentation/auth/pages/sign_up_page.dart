import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/data/auth/models/user_sign_up_req.dart';
import 'package:star_shop/features/domain/auth/use_cases/sign_up_use_case.dart';
import 'package:star_shop/features/presentation/auth/bloc/password_cubit.dart';
import 'package:star_shop/features/presentation/auth/pages/sign_in_page.dart';
import 'package:star_shop/features/presentation/auth/widgets/confirm_password_text_field.dart';
import 'package:star_shop/features/presentation/auth/widgets/email_text_field.dart';
import 'package:star_shop/features/presentation/auth/widgets/password_text_field.dart';
import 'package:star_shop/features/presentation/home/pages/home_page.dart';
import 'package:star_shop/utils/bloc/button/button_cubit.dart';
import 'package:star_shop/utils/bloc/button/button_state.dart';
import 'package:star_shop/utils/widgets/button/reactive_button.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register to STARSHOP',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
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
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false);
            }
            if (state is ButtonFailureState) {
              if (state.errorCode == 'too-many-requests'){
                //show snackbar
              }
              print('Loi: ' + state.errorCode);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
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
                  height: 48,
                ),
                _signUpButton(context),
                const Spacer(),
                _signInText(context),
                const SizedBox(
                  height: 50,
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
            fontSize: 18,
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
              fontSize: 18,
            ),
          ),
        )
      ],
    );
  }
}
