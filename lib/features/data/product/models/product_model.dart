import 'package:star_shop/features/data/product/models/review_model.dart';

class ProductModel{
  final String productID;
  final String title;
  final String description;
  final String categoryID;
  final num price;
  final num oldPrice;
  final List<String> images;
  final int quantityInStock;
  final int salesNumber;
  final double rating;
  final List<ReviewModel> reviews;

  ProductModel({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'productID': productID,
      'title': title,
      'description': description,
      'categoryID': categoryID,
      'price': price,
      'oldPrice': oldPrice,
      'images': images.map((map) => map.toString()).toList(),
      'quantityInStock': quantityInStock,
      'salesNumber': salesNumber,
      'rating': rating,
      'reviews': reviews.map((map) => map.toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productID: map['productID'],
      title: map['title'],
      description: map['description'],
      categoryID: map['categoryID'],
      price: map['price'],
      oldPrice: map['oldPrice'],
      images: List<String>.from(map['images'].map((e) => e.toString()).toList()),
      quantityInStock: map['quantityInStock'],
      salesNumber: map['salesNumber'],
      rating: map['rating'],
      reviews: List<ReviewModel>.from(map['reviews'].map((e) => ReviewModel.fromMap(e)).toList()),
    );
  }
}