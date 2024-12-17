import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/categories/categories_display_cubit.dart';
import 'package:star_shop/common/bloc/categories/categories_display_state.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/common/widgets/network_image/app_network_image.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/category/entities/category_entity.dart';
import 'package:star_shop/features/presentation/category/pages/view_all_categories_page.dart';
import 'package:star_shop/features/presentation/product/pages/products_by_category_page.dart';

class HomePageCategories extends StatelessWidget {
  const HomePageCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryTextColor,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewAllCategoriesPage()));
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.subtextColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.subtextColor,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
          builder: (context, state) {
            if (state is CategoriesLoaded) {
              List<CategoryEntity> categories = state.categories;
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductsByCategoryPage(
                                      category: categories[index],
                                    )));
                      },
                      child: Column(
                        children: [
                          AppNetworkImage(
                            width: 60,
                            height: 60,
                            image: categories[index].image,
                            radius: 10,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            categories[index].title,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 14,
                    );
                  },
                  itemCount: 7,
                ),
              );
            }

            if (state is CategoriesLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            if (state is CategoriesLoadFailure) {
              return AppErrorWidget(onPress: () {
                context.read<CategoriesDisplayCubit>().getCategories();
              });
            }

            if (state is CategoriesInitialState) {
              context.read<CategoriesDisplayCubit>().getCategories();
            }

            return Container();
          },
          // child: ,
        ),
      ],
    );
  }
}
