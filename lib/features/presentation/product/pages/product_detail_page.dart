import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/bloc/favorite/favorite_product_cubit.dart';
import 'package:star_shop/common/bloc/favorite/favorite_product_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';
import 'package:star_shop/common/widgets/snack_bar/app_snack_bar.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';
import 'package:star_shop/features/domain/order/use_cases/add_product_to_cart_use_case.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/presentation/cart/bloc/cart_display_cubit.dart';
import 'package:star_shop/features/presentation/product/bloc/product_image_selection_cubit.dart';
import 'package:star_shop/features/presentation/product/bloc/product_quantity_selection_cubit.dart';
import 'package:star_shop/features/presentation/product/widgets/product_detail_image_slider.dart';
import 'package:star_shop/features/presentation/product/widgets/product_detail_information.dart';
import 'package:star_shop/features/presentation/product/widgets/product_detail_item_image.dart';
import 'package:star_shop/features/presentation/product/widgets/product_detail_quantity_selection.dart';
import 'package:star_shop/features/presentation/product/widgets/product_detail_rating_review.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  final CarouselSliderController buttonCarouselController =
  CarouselSliderController();

  late ProductOrderedEntity productOrdered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: 'Product Details',
        centerTitle: true,
        action: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BlocBuilder<FavoriteProductCubit, FavoriteProductState>(
                builder: (context, state) {
              bool isFavorite = false;

              if (state is FavoriteProductLoaded) {
                List<ProductEntity> products = state.products;

                List<ProductEntity> re = products
                    .where((e) => e.productID == widget.productEntity.productID)
                    .toList();
                if (re.isNotEmpty) {
                  isFavorite = true;
                } else {
                  isFavorite = false;
                }
              }

              return IconButton(
                onPressed: () {
                  context
                      .read<FavoriteProductCubit>()
                      .toggleFavorite(widget.productEntity);
                },
                icon: isFavorite
                    ? const Icon(
                        Icons.favorite,
                        color: AppColors.textColor,
                        size: 22,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: AppColors.textColor,
                        size: 22,
                      ),
              );
            }),
          )
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ButtonCubit(),),
          BlocProvider(create: (context) => ProductImageSelectionCubit(),),
          BlocProvider(create: (context) => ProductQuantitySelectionCubit(),),
        ],

        child: BlocListener<ButtonCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              context.read<CartDisplayCubit>().addProductToCart(productOrdered);
              AppSnackBar.showAppSnackBar(
                  context: context,
                  title: 'The product has been added to the cart!');
            }

            if (state is ButtonFailureState) {
              AppSnackBar.showAppSnackBarFailure(
                  context: context,
                  title: state.errorCode);
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ProductDetailImageSlider(
                      buttonCarouselController: buttonCarouselController,
                      images: widget.productEntity.images,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ProductDetailItemImage(
                                    buttonCarouselController: buttonCarouselController,
                                    index: index,
                                    images: widget.productEntity.images[index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 16,
                                  );
                                },
                                itemCount: widget.productEntity.images.length),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ProductDetailInformation(
                              productEntity: widget.productEntity),
                          const SizedBox(
                            height: 16,
                          ),
                          const ProductDetailRatingReview(),
                          const SizedBox(
                            height: 55,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 8),
                  color: AppColors.backgroundColor,
                  child: Row(
                    children: [
                      const ProductDetailQuantitySelection(),
                      const SizedBox(
                        width: 16,
                      ),
                      BlocBuilder<ProductQuantitySelectionCubit, int>(
                        builder: (context, state) {
                          return Expanded(
                            child: Builder(builder: (context) {
                              return ReactiveButton(
                                onPressed: () async {
                                  if (state == 0) {
                                    AppSnackBar.showAppSnackBar(
                                        context: context,
                                        title: 'Please select product quantity.');
                                  } else {
                                    ProductEntity product = widget.productEntity;
                                    productOrdered = ProductOrderedEntity(
                                      productID: product.productID,
                                      title: product.title,
                                      price: product.price,
                                      totalPrice: state * product.price,
                                      images: product.images[0],
                                      quantity: state,
                                    );
                                    context.read<ButtonCubit>().execute(
                                          useCase: AddProductToCartUseCase(),
                                          params: productOrdered,
                                        );
                                  }
                                },
                                title: 'Add to Cart',
                              );
                            }),
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
