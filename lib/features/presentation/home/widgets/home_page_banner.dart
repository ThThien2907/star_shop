import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:star_shop/configs/assets/app_images.dart';

class HomePageBanner extends StatelessWidget {
  const HomePageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      AppImages.banner1,
      AppImages.banner2,
      AppImages.banner3,
    ];

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      child: CarouselSlider.builder(
        itemCount: images.length,
        itemBuilder: (context, index, pageIndex) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
        options: CarouselOptions(
          aspectRatio: 1,
          enableInfiniteScroll: true,
          viewportFraction: 1,
          autoPlay: true,
        ),
      ),
    );
  }
}
