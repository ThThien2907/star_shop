import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_cubit.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_state.dart';
import 'package:star_shop/common/bloc/favorite/favorite_product_cubit.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/presentation/auth/pages/update_address_page.dart';
import 'package:star_shop/features/presentation/auth/pages/update_profile_page.dart';
import 'package:star_shop/features/presentation/auth/pages/verify_email_page.dart';
import 'package:star_shop/features/presentation/cart/bloc/cart_display_cubit.dart';
import 'package:star_shop/features/presentation/cart/pages/cart_page.dart';
import 'package:star_shop/features/presentation/favorite/pages/favorite_page.dart';
import 'package:star_shop/features/presentation/home/pages/home_page.dart';
import 'package:star_shop/features/presentation/profile/pages/profile_page.dart';

class AppBottomNav extends StatefulWidget {
  const AppBottomNav({
    super.key,
  });

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  List<BottomNavigationBarItem> listItem = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border), label: 'Saved'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.person_outline), label: 'Account'),
  ];

  // List<Widget> listPage = [
  //   const HomePage(),
  //   const FavoritePage(),
  //   const CartPage(),
  //   const ProfilePage()
  // ];

  int activePage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..getUser(),
      child: BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
        builder: (context, state) {
          if (state is UserInfoLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            );
          }
          if (state is UserInfoLoadFailure) {
            return Scaffold(
              body: Center(
                child: AppErrorWidget(
                  onPress: () {
                    context.read<UserInfoDisplayCubit>().getUser();
                  },
                ),
              ),
            );
          }

          if (state is UserInfoIsEmpty) {
            return const UpdateProfilePage();
          }

          if (state is UserAddressIsEmpty) {
            return const UpdateAddressPage();
          }

          if (state is EmailNotVerified) {
            return const VerifyEmailPage();
          }

          if (state is UserInfoLoaded) {
            UserEntity userEntity = state.userEntity;
            List<Widget> listPage = [
              HomePage(userEntity: userEntity),
              const FavoritePage(),
              const CartPage(),
              const ProfilePage()
            ];
            return Scaffold(
              extendBody: true,
              body: IndexedStack(
                index: activePage,
                children: listPage,
              ),
              // body: listPage[activePage],
              bottomNavigationBar: BottomNavigationBar(
                items: listItem,
                currentIndex: activePage,
                onTap: (value) {
                  setState(() {
                    activePage = value;
                  });
                },
              ),
            );
          }
          return const Scaffold();
        },
      ),
    );
  }
}
