import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/categories/categories_display_cubit.dart';
import 'package:star_shop/common/bloc/categories/categories_display_state.dart';
import 'package:star_shop/common/widgets/button/app_button_outline.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/common/widgets/network_image/app_network_image.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/admin/presentation/category/pages/add_or_update_category_page.dart';
import 'package:star_shop/features/domain/category/entities/category_entity.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
        builder: (context, state) {
          if (state is CategoriesInitialState) {
            context.read<CategoriesDisplayCubit>().getCategories();
          }

          if (state is CategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (state is CategoriesLoadFailure) {
            return Center(
              child: AppErrorWidget(onPress: () {
                context.read<CategoriesDisplayCubit>().getCategories();
              }),
            );
          }

          if (state is CategoriesLoaded) {
            List<CategoryEntity> categories = state.categories;

            return Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppButtonOutline(
                    onPressed: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddOrUpdateCategoryPage(
                                    isUpdate: false,
                                  )));
                      if (result != null){
                        context.read<CategoriesDisplayCubit>().getCategories();
                      }
                    },
                    widget: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColors.textColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Add New Category',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: InkWell(
                            onTap: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddOrUpdateCategoryPage(
                                        isUpdate: true,
                                        categoryEntity: categories[index],
                                      )));
                              if (result != null){
                                context.read<CategoriesDisplayCubit>().getCategories();
                              }
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 80,
                              child: Row(
                                children: [
                                  AppNetworkImage(
                                    width: 60,
                                    height: 60,
                                    image: categories[index].image,
                                    radius: 10,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Text(
                                    categories[index].title,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                          color: AppColors.grey,
                          indent: 16,
                          endIndent: 16,
                          thickness: 1.5,
                        );
                      },
                      itemCount: categories.length,
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
