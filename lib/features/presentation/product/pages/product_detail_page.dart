import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/bloc/favorite/favorite_product_cubit.dart';
import 'package:star_shop/common/bloc/favorite/favorite_product_state.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/presentation/product/widgets/product_detail_image_slider.dart';
import 'package:star_shop/features/presentation/product/widgets/product_detail_information.dart';
import 'package:star_shop/features/presentation/product/widgets/product_detail_item_image.dart';
import 'package:star_shop/features/presentation/product/widgets/product_detail_rating_review.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  int selectedImage = 0;

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
      body: BlocProvider(
        create: (context) => ButtonCubit(),
        child: BlocListener<ButtonCubit, ButtonState>(
          listener: (context, state) {},
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ProductDetailImageSlider(
                      buttonCarouselController: buttonCarouselController,
                      images: widget.productEntity.images,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedImage = index;
                        });
                      },
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
                                    selectedImage: selectedImage,
                                    index: index,
                                    images: widget.productEntity.images,
                                    onTap: () {
                                          setState(() {
                                            selectedImage = index;
                                          });
                                          buttonCarouselController.animateToPage(
                                              index,
                                              duration: const Duration(milliseconds: 200),
                                              curve: Curves.linear);
                                    },
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
                          ProductDetailInformation(productEntity: widget.productEntity),
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
                child: Builder(builder: (context) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: ReactiveButton(
                      onPressed: () {},
                      title: 'Add to Cart',
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
