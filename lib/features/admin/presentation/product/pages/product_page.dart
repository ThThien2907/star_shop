import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/products/load_more_products_cubit.dart';
import 'package:star_shop/common/bloc/products/load_more_products_state.dart';
import 'package:star_shop/common/bloc/products/products_display_cubit.dart';
import 'package:star_shop/common/bloc/products/products_display_state.dart';
import 'package:star_shop/common/widgets/button/app_button_outline.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/common/widgets/product/products_grid_view.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/admin/presentation/product/pages/add_or_update_product_page.dart';
import 'package:star_shop/features/presentation/search/pages/product_search_page.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/domain/product/use_cases/get_products_by_update_at_use_case.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  ProductsDisplayCubit(useCase: GetProductsByUpdateAtUseCase())
                    ..getProducts(params: 8)),
          BlocProvider(create: (context) => LoadMoreProductsCubit(useCase: GetProductsByUpdateAtUseCase())),
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
              int limit = 8;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductSearchPage(isEdit: true,)));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        backgroundColor: const Color(0xff09090C),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.search_outlined,
                            size: 26,
                            color: AppColors.subtextColor,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Enter the product name to search',
                            style: TextStyle(
                                color: AppColors.subtextColor, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButtonOutline(
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddOrUpdateProductPage(
                                  isUpdate: false,
                                )));
                        if(result == 'Data has changed') {
                          context.read<ProductsDisplayCubit>().getProducts(params: 8);
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
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<LoadMoreProductsCubit, LoadMoreProductsState>(
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

                        return Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ProductsGridView(
                                  products: products,
                                  itemCount: products.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  isEdit: true,
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
                                                decoration:
                                                    TextDecoration.underline,
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
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
