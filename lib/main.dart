import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/widgets/bottom_nav/app_bottom_nav.dart';
import 'package:star_shop/configs/theme/app_themes.dart';
import 'package:star_shop/features/presentation/auth/pages/create_new_password_page.dart';
import 'package:star_shop/features/presentation/auth/pages/update_profile_page.dart';
import 'package:star_shop/features/presentation/auth/pages/forget_password_page.dart';
import 'package:star_shop/features/presentation/auth/pages/sign_in_page.dart';
import 'package:star_shop/features/presentation/get_started/pages/get_started_page.dart';
import 'package:star_shop/features/presentation/home/pages/home_page.dart';
import 'package:star_shop/features/presentation/splash/pages/splash_page.dart';
import 'package:star_shop/firebase_options.dart';
import 'package:star_shop/service_locator.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppThemes.appTheme,
        debugShowCheckedModeBanner: false,
        home: UpdateProfilePage()
    );
  }
}
