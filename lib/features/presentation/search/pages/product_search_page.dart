import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/products/products_display_cubit.dart';
import 'package:star_shop/common/bloc/products/products_display_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/common/widgets/input_field/search_field.dart';
import 'package:star_shop/common/widgets/product/products_grid_view.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/domain/product/use_cases/get_product_by_name_use_case.dart';

class ProductSearchPage extends StatelessWidget {
  const ProductSearchPage({super.key,required this.isEdit});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsDisplayCubit(useCase: GetProductByNameUseCase()),
      child: Scaffold(
        appBar: const BasicAppBar(
          title: 'Product Search',
          centerTitle: true,
        ),
        body: Column(
          children: [
            Builder(
              builder: (context) {
                return SearchField(
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      context
                          .read<ProductsDisplayCubit>()
                          .getProducts(params: value);
                    } else {
                      context.read<ProductsDisplayCubit>().displayInitialState();
                    }
                  },
                );
              }
            ),
            Expanded(
              child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
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
                          context
                              .read<ProductsDisplayCubit>()
                              .getProducts(params: 8);
                        },
                      ),
                    );
                  }

                  if (state is ProductsLoaded) {
                    List<ProductEntity> products = state.products;
                    return products.isNotEmpty
                        ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: ProductsGridView(
                              isEdit: isEdit,
                              products: products,
                              itemCount: products.length,
                            ),
                        )
                        : const Center(
                            child: Text('No search result'),
                          );
                  }

                  return const Center(
                    child: Text('No search result'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
