import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/products/products_display_cubit.dart';
import 'package:star_shop/common/bloc/products/products_display_state.dart';
import 'package:star_shop/common/bloc/products/load_more_products_cubit.dart';
import 'package:star_shop/common/bloc/products/load_more_products_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/common/widgets/product/products_grid_view.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/domain/product/use_cases/get_products_use_case.dart';

class ViewAllProductsPage extends StatefulWidget {
  const ViewAllProductsPage({super.key});

  @override
  State<ViewAllProductsPage> createState() => _ViewAllProductsPageState();
}

class _ViewAllProductsPageState extends State<ViewAllProductsPage> {
  int limit = 8;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'All Products',
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  ProductsDisplayCubit(useCase: GetProductsUseCase())
                    ..getProducts(params: limit)),
          BlocProvider(create: (context) => LoadMoreProductsCubit()),
        ],
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
              return AppErrorWidget(
                onPress: () {
                  context.read<ProductsDisplayCubit>().getProducts();
                },
              );
            }

            if (state is ProductsLoaded) {
              List<ProductEntity> products = state.products;

              return BlocBuilder<LoadMoreProductsCubit, LoadMoreProductsState>(
                builder: (context, loadMoreState) {
                  bool isLoading = false;
                  bool isHasMore = true;

                  if (loadMoreState is LoadMoreProductsLoaded) {
                    products = loadMoreState.products;
                    isHasMore = products.length == limit;
                  }

                  if (loadMoreState is LoadMoreProductsLoading) {
                    isLoading = true;
                  }

                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProductsGridView(
                            products: products,
                            itemCount: products.length,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          isLoading
                              ? const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : isHasMore
                                  ? TextButton(
                                      onPressed: () {
                                        limit += 8;
                                        context
                                            .read<LoadMoreProductsCubit>()
                                            .loadMoreProducts(limit);
                                      },
                                      child: const Text(
                                        'Load more...',
                                        style: TextStyle(
                                          color: AppColors.subtextColor,
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              AppColors.subtextColor,
                                        ),
                                      ),
                                    )
                                  : Container()
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
