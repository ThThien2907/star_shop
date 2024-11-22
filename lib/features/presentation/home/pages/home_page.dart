import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_cubit.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_state.dart';
import 'package:star_shop/common/bloc/categories/categories_display_cubit.dart';
import 'package:star_shop/common/bloc/categories/categories_display_state.dart';
import 'package:star_shop/common/bloc/products/products_display_cubit.dart';
import 'package:star_shop/common/bloc/products/products_display_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/button/app_button.dart';
import 'package:star_shop/common/widgets/network_image/app_network_image.dart';
import 'package:star_shop/configs/assets/app_images.dart';
import 'package:star_shop/configs/assets/app_vectors.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/domain/category/entities/category_entity.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/domain/product/use_cases/get_top_selling_use_case.dart';
import 'package:star_shop/features/presentation/auth/pages/sign_in_page.dart';
import 'package:star_shop/features/presentation/home/widgets/home_page_banner.dart';
import 'package:star_shop/features/presentation/home/widgets/home_page_categories.dart';
import 'package:star_shop/features/presentation/home/widgets/home_page_top_selling.dart';
import 'package:star_shop/features/presentation/home/widgets/home_page_search_bar.dart';
import 'package:star_shop/features/presentation/notification/pages/notification_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello',
              style: TextStyle(
                color: AppColors.subtextColor,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              userEntity.fullName,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        action: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
            icon: Icon(
              Icons.notifications_none,
              size: 28,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => CategoriesDisplayCubit()..getCategories()),
          BlocProvider(
              create: (context) =>
                  ProductsDisplayCubit(useCase: GetTopSellingUseCase())
                    ..getProducts(params: 8)),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomePageSearchBar(),
                SizedBox(
                  height: 16,
                ),
                HomePageCategories(),
                SizedBox(
                  height: 20,
                ),
                HomePageBanner(),
                SizedBox(
                  height: 48,
                ),
                HomePageTopSelling(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
