import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/products/products_display_cubit.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/domain/product/use_cases/get_top_selling_use_case.dart';
import 'package:star_shop/features/presentation/home/widgets/home_page_banner.dart';
import 'package:star_shop/features/presentation/home/widgets/home_page_categories.dart';
import 'package:star_shop/features/presentation/home/widgets/home_page_top_selling.dart';
import 'package:star_shop/features/presentation/home/widgets/home_page_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  ProductsDisplayCubit(useCase: GetTopSellingUseCase())
                    ..getProducts(params: 8)),
        ],
        child: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
