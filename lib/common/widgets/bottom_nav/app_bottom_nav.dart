import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_cubit.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_state.dart';
import 'package:star_shop/common/widgets/app_bar/app_bar_notification_icon.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/admin/presentation/navigation_drawer/pages/navigation_drawer_page.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/presentation/account/pages/account_page.dart';
import 'package:star_shop/features/presentation/auth/pages/add_or_update_address_page.dart';
import 'package:star_shop/features/presentation/auth/pages/add_or_update_profile_page.dart';
import 'package:star_shop/features/presentation/auth/pages/verify_email_page.dart';
import 'package:star_shop/features/presentation/cart/pages/cart_page.dart';
import 'package:star_shop/features/presentation/favorite/pages/favorite_page.dart';
import 'package:star_shop/features/presentation/home/pages/home_page.dart';
import 'package:star_shop/features/presentation/notification/bloc/notification_display_cubit.dart';
import 'package:star_shop/features/presentation/notification/bloc/notification_display_state.dart';

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

  int activePage = 0;

  @override
  void initState() {
    super.initState();
    context.read<UserInfoDisplayCubit>().getUser();
  }

  @override
  void didChangeDependencies() {
    context.read<NotificationDisplayCubit>().stopListening();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
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
          return const AddOrUpdateProfilePage(isUpdateProfile: false,);
        }

        if (state is UserAddressIsEmpty) {
          return const AddOrUpdateAddressPage(isFirstAddress: true,);
        }

        if (state is EmailNotVerified) {
          return const VerifyEmailPage();
        }

        if (state is IsAdmin) {
          if(context.read<NotificationDisplayCubit>().state is NotificationDisplayInitialState){
            context.read<NotificationDisplayCubit>().listenToCollection('admin');

          }
          return NavigationDrawerPage(userEntity: state.userEntity, activePage: 0,);
        }

        if (state is UserInfoLoaded) {
          UserEntity userEntity = state.userEntity;
          if(context.read<NotificationDisplayCubit>().state is NotificationDisplayInitialState){
            context.read<NotificationDisplayCubit>().listenToCollection(userEntity.userId);
          }

          List<Widget> listAppBarTitle = [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello',
                  style: TextStyle(
                    color: AppColors.subtextColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  userEntity.fullName,
                  style: const TextStyle(
                    color: AppColors.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text(
              'Favorites',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'My Cart',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Account',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ];

          List<Widget> listPage = [
            HomePage(userEntity: userEntity),
            const FavoritePage(),
            const CartPage(),
            const AccountPage()
          ];
          return Scaffold(
            // extendBody: true,
            appBar: AppBarNotificationIcon(
              widget: listAppBarTitle[activePage],
              centerTitle: activePage == 0 ? false : true,
            ),
            body: IndexedStack(
              index: activePage,
              children: listPage,
            ),
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
    );
  }
}
