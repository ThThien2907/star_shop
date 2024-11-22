import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/products/products_display_cubit.dart';
import 'package:star_shop/common/bloc/products/products_display_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/common/widgets/product/products_grid_view.dart';
import 'package:star_shop/features/domain/category/entities/category_entity.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/domain/product/use_cases/get_products_by_category_use_case.dart';

class ProductsByCategoryPage extends StatelessWidget {
  const ProductsByCategoryPage({super.key, required this.category});

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: category.title,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            ProductsDisplayCubit(useCase: GetProductsByCategoryUseCase())
              ..getProducts(params: category.categoryID),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ProductsLoadFailure) {
                return AppErrorWidget(
                  onPress: () {
                    context.read<ProductsDisplayCubit>().getProducts(params: category.categoryID);
                  },
                );
              }

              if (state is ProductsLoaded) {
                List<ProductEntity> products = state.products;

                return ProductsGridView(products: products);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
