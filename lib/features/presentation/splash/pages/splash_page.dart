import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_shop/common/widgets/bottom_nav/app_bottom_nav.dart';
import 'package:star_shop/configs/assets/app_vectors.dart';
import 'package:star_shop/features/presentation/get_started/pages/get_started_page.dart';
import 'package:star_shop/features/presentation/splash/bloc/splash_cubit.dart';
import 'package:star_shop/features/presentation/splash/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SplashCubit()..appStarted(),
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is LoggedIn) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AppBottomNav()));
            }
            if (state is NotLoggedIn) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const GetStartedPage()));
            }
          },
          child: Center(
            child: SvgPicture.asset(
              AppVectors.appLogo,
            ),
          ),
        ),
      ),
    );
  }
}
