import 'package:star_shop/features/domain/product/entities/review_entity.dart';

class ProductEntity{
  final String productID;
  final String title;
  final String description;
  final String categoryID;
  final num price;
  final num oldPrice;
  final List<String> images;
  final num quantityInStock;
  final num salesNumber;
  final num rating;
  final List<ReviewEntity> reviews;

  ProductEntity({
    required this.productID,
    required this.title,
    required this.description,
    required this.categoryID,
    required this.price,
    required this.oldPrice,
    required this.images,
    required this.quantityInStock,
    required this.salesNumber,
    required this.rating,
    required this.reviews,
  });

  @override
  String toString() {
    return 'ProductEntity{productID: $productID}';
  }
}