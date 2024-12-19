import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:star_shop/common/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:star_shop/common/widgets/bottom_sheet/confirm_event_bottom_sheet.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/presentation/account/widgets/account_page_item.dart';
import 'package:star_shop/features/presentation/address/pages/address_page.dart';
import 'package:star_shop/features/presentation/auth/pages/sign_in_page.dart';
import 'package:star_shop/features/presentation/notification/pages/notification_page.dart';
import 'package:star_shop/features/presentation/order/pages/order_page.dart';
import 'package:star_shop/features/presentation/profile/pages/profile_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            AccountPageItem(
              title: 'My Profile',
              icon: Icons.person_outline,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AccountPageItem(
              title: 'My Address',
              icon: Icons.location_on_outlined,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddressPage()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AccountPageItem(
              title: 'My Order',
              icon: Icons.view_list_outlined,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPage()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AccountPageItem(
                title: 'Payment Methods', icon: Icons.payment, onTap: () {}),
            const SizedBox(
              height: 16,
            ),
            AccountPageItem(
                title: 'Notifications',
                icon: Icons.notifications_none,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationPage()));
                }),
            const SizedBox(
              height: 16,
            ),
            AccountPageItem(
                title: 'Privacy Policy',
                icon: Icons.policy_outlined,
                onTap: () {}),
            const SizedBox(
              height: 16,
            ),
            AccountPageItem(
                title: 'Help Center', icon: Icons.help_outline, onTap: () {}),
            const SizedBox(
              height: 16,
            ),
            AccountPageItem(
                title: 'Invite Friends', icon: Icons.person_add, onTap: () {}),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: AccountPageItem(
                title: 'Log Out',
                icon: Icons.logout_outlined,
                color: AppColors.red,
                hideArrow: true,
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
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
