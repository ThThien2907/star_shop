import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductDetailImageSlider extends StatelessWidget {
  const ProductDetailImageSlider({
    super.key,
    required this.images,
    required this.onPageChanged,
    required this.buttonCarouselController,
  });

  final List<String> images;
  final CarouselSliderController buttonCarouselController;
  final Function(int, CarouselPageChangedReason) onPageChanged;

  @override
  Widget build(BuildContext context) {
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
        onPageChanged: onPageChanged,
      ),
    );
  }
}
