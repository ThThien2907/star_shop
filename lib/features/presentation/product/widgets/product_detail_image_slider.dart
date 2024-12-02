import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/features/presentation/product/bloc/product_image_selection_cubit.dart';

class ProductDetailImageSlider extends StatelessWidget {
  const ProductDetailImageSlider({
    super.key,
    required this.images,
    required this.buttonCarouselController,
  });

  final List<String> images;
  final CarouselSliderController buttonCarouselController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductImageSelectionCubit, int>(
      builder: (context, state) {
        return CarouselSlider.builder(
          carouselController: buttonCarouselController,
          itemCount: images.length,
          itemBuilder: (context, index, pageIndex) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(images[index]),
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
          options: CarouselOptions(
            aspectRatio: 1,
            enableInfiniteScroll: false,
            viewportFraction: 1,
            onPageChanged: (index, reason){
              context.read<ProductImageSelectionCubit>().imageSelection(index);
            },
          ),
        );
      }
    );
  }
}
