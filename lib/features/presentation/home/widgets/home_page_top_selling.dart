import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/products/products_display_cubit.dart';
import 'package:star_shop/common/bloc/products/products_display_state.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/common/widgets/product/products_grid_view.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/presentation/product/pages/view_all_products_page.dart';

class HomePageTopSelling extends StatelessWidget {
  const HomePageTopSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Top Selling',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.primaryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllProductsPage()));
              },
              child: const Text(
                'View All Products',
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
        BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            if (state is ProductsLoadFailure) {
              return Center(
                child: AppErrorWidget(
                  onPress: () {
                    context.read<ProductsDisplayCubit>().getProducts(params: 8);
                  },
                ),
              );
            }

            if (state is ProductsLoaded) {
              List<ProductEntity> products = state.products;

              return ProductsGridView(
                products: products,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}
