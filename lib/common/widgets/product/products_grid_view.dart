import 'package:flutter/material.dart';
import 'package:star_shop/common/widgets/product/product_card.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    super.key,
    required this.products,
    this.physics,
    required this.itemCount,
    this.scrollController, required this.isEdit,
  });

  final List<ProductEntity> products;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final int itemCount;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      physics: physics,
      shrinkWrap: true,
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.5,
      ),
      itemBuilder: (context, index) {
        return ProductCard(productEntity: products[index], isEdit: isEdit,);
      },
    );
  }
}
