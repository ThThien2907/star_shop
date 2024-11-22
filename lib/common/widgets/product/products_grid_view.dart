import 'package:flutter/material.dart';
import 'package:star_shop/common/widgets/product/product_card.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key, required this.products, this.physics});

  final List<ProductEntity> products;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: physics,
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 24,
        childAspectRatio: 0.5,
      ),
      itemBuilder: (context, index) {
        return ProductCard(productEntity: products[index]);
      },
    );
  }
}
