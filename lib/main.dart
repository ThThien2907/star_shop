import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_cubit.dart';
import 'package:star_shop/common/bloc/categories/categories_display_cubit.dart';
import 'package:star_shop/configs/theme/app_themes.dart';
import 'package:star_shop/features/presentation/address/bloc/address_display_cubit.dart';
import 'package:star_shop/common/bloc/favorite/favorite_product_cubit.dart';
import 'package:star_shop/features/presentation/cart/bloc/cart_display_cubit.dart';
import 'package:star_shop/features/presentation/splash/pages/splash_page.dart';
import 'package:star_shop/firebase_options.dart';
import 'package:star_shop/service_locator.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavoriteProductCubit(),),
        BlocProvider(create: (context) => CategoriesDisplayCubit(),),
        BlocProvider(create: (context) => CartDisplayCubit(),),
        BlocProvider(create: (context) => UserInfoDisplayCubit()),
        BlocProvider(create: (context) => AddressDisplayCubit()),
      ],
      child: MaterialApp(
          theme: AppThemes.appTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashPage()
      ),
    );
  }
}
