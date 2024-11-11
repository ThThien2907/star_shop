import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/presentation/cart/pages/cart_page.dart';
import 'package:star_shop/features/presentation/favorite/pages/favorite_page.dart';
import 'package:star_shop/features/presentation/home/pages/home_page.dart';
import 'package:star_shop/features/presentation/profile/pages/profile_page.dart';

class AppBottomNav extends StatefulWidget {
  const AppBottomNav({super.key});

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  List<BottomNavigationBarItem> listItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Saved'),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
  ];

  List<Widget> listPage = [HomePage(), FavoritePage(), CartPage(), ProfilePage()];

  int activePage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: listPage[activePage],
      bottomNavigationBar: BottomNavigationBar(
        items: listItem,
        currentIndex: activePage,
        onTap: (value){
          setState(() {
            activePage = value;
          });
        },
      ),
    );
  }
}
