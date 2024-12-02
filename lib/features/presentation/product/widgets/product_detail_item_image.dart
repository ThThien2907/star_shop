import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/presentation/product/bloc/product_image_selection_cubit.dart';

class ProductDetailItemImage extends StatelessWidget {
  const ProductDetailItemImage({
    super.key,
    required this.images,
    required this.index,
    required this.buttonCarouselController,
  });

  final int index;
  final String images;
  final CarouselSliderController buttonCarouselController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductImageSelectionCubit, int>(
        builder: (context, state) {
      return GestureDetector(
        onTap: () {
          context.read<ProductImageSelectionCubit>().imageSelection(index);
          buttonCarouselController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: index == state
                ? Border.all(color: AppColors.primaryColor, width: 3)
                : null,
            image: DecorationImage(
              image: NetworkImage(images),
              fit: BoxFit.cover,
              colorFilter: index == state ? null : ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
            ),
          ),
        ),
      );
    });
  }
}
