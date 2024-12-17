import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/categories/categories_display_cubit.dart';
import 'package:star_shop/common/bloc/categories/categories_display_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/common/widgets/network_image/app_network_image.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/category/entities/category_entity.dart';
import 'package:star_shop/features/presentation/product/pages/products_by_category_page.dart';

class ViewAllCategoriesPage extends StatelessWidget {
  const ViewAllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'All Categories',
        centerTitle: true,
      ),
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
              child: AppErrorWidget(onPress: (){
                context.read<CategoriesDisplayCubit>().getCategories();
              },)
            );
          }

          if (state is CategoriesLoaded) {
            List<CategoryEntity> categories = state.categories;

            return ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsByCategoryPage(category: categories[index],)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                itemCount: categories.length);
          }

          return Container();
        },
      ),
    );
  }
}
