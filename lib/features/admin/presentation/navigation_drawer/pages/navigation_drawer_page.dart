import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_shop/common/widgets/app_bar/app_bar_notification_icon.dart';
import 'package:star_shop/common/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:star_shop/common/widgets/bottom_sheet/confirm_event_bottom_sheet.dart';
import 'package:star_shop/configs/assets/app_vectors.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/admin/presentation/category/pages/category_page.dart';
import 'package:star_shop/features/admin/presentation/dashboard/pages/dashboard_page.dart';
import 'package:star_shop/features/admin/presentation/order/pages/order_page.dart';
import 'package:star_shop/features/admin/presentation/product/pages/product_page.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/presentation/auth/pages/sign_in_page.dart';

class NavigationDrawerPage extends StatefulWidget {
  const NavigationDrawerPage({super.key, required this.userEntity, required this.activePage});

  final UserEntity userEntity;
  final int activePage;

  @override
  State<NavigationDrawerPage> createState() => _NavigationDrawerPageState();
}

class _NavigationDrawerPageState extends State<NavigationDrawerPage> {
  List<Widget> listPage = [const DashboardPage(),const ProductPage(), const CategoryPage(), const OrderPage()];
  List<String> appBarTitle = ['Dashboard', 'Product', 'Category', 'Order'];
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    activePage = widget.activePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNotificationIcon(
        title: appBarTitle[activePage],
        centerTitle: true,
      ),
      body: IndexedStack(
        index: activePage,
        children: listPage,
      ),
      drawer: Drawer(
        backgroundColor: AppColors.backgroundColor,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor
              ),
              accountName: Text(widget.userEntity.fullName, style: const TextStyle(fontSize: 16, color: AppColors.primaryTextColor),),
              accountEmail: Text(widget.userEntity.email, style: const TextStyle(fontSize: 16, color: AppColors.primaryTextColor),),
              currentAccountPicture: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Center(child: SvgPicture.asset(AppVectors.appLogo)),
              ),
              currentAccountPictureSize: const Size(200, 100),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: AppColors.primaryTextColor,),
              title: const Text('Dashboard', style: TextStyle(fontSize: 16, color: AppColors.primaryTextColor),),
              onTap: () {
                setState(() {
                  activePage = 0;
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16,),
            ListTile(
              leading: const Icon(Icons.inventory, color: AppColors.primaryTextColor,),
              title: const Text('Product', style: TextStyle(fontSize: 16, color: AppColors.primaryTextColor),),
              onTap: () {
                setState(() {
                  activePage = 1;
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16,),
            ListTile(
              leading: const Icon(Icons.category, color: AppColors.primaryTextColor,),
              title: const Text('Category', style: TextStyle(fontSize: 16, color: AppColors.primaryTextColor),),
              onTap: () {
                setState(() {
                  activePage = 2;
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16,),
            ListTile(
              leading: const Icon(Icons.list, color: AppColors.primaryTextColor,),
              title: const Text('Order', style: TextStyle(fontSize: 16, color: AppColors.primaryTextColor),),
              onTap: () {
                setState(() {
                  activePage = 3;
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 32,),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.red,),
              title: const Text('Log Out', style: TextStyle(fontSize: 16, color: AppColors.red),),
              onTap: () {
                AppBottomSheet.display(
                  context: context,
                  widget: ConfirmEventBottomSheet(
                    title: 'Log Out',
                    subtitle: 'Are you sure you want to log out?',
                    confirmText: 'Yes, Log Out',
                    onPressedCancelButton: () {
                      Navigator.pop(context);
                    },
                    onPressedYesButton: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()),
                              (route) => false);
                    },
                  ),
                  height: 250,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
