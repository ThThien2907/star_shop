import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/product/data_sources/product_firebase_service.dart';
import 'package:star_shop/features/data/product/models/product_model.dart';
import 'package:star_shop/features/data/product/models/review_model.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/domain/product/entities/review_entity.dart';
import 'package:star_shop/features/domain/product/repositories/product_repository.dart';
import 'package:star_shop/service_locator.dart';

class ProductRepositoryImpl implements ProductRepository {



  ProductEntity productToEntity(ProductModel model) {
    return ProductEntity(
      productID: model.productID,
      title: model.title,
      description: model.description,
      categoryID: model.categoryID,
      price: model.price,
      oldPrice: model.oldPrice,
      images: model.images,
      quantityInStock: model.quantityInStock,
      salesNumber: model.salesNumber,
      rating: model.rating,
      reviews: model.reviews.map((e) => reviewToEntity(e)).toList(),
    );
  }

  ReviewEntity reviewToEntity(ReviewModel model) {
    return ReviewEntity(
      userId: model.userId,
      userName: model.userName,
      reviewId: model.reviewId,
      rating: model.rating,
      review: model.review,
    );
  }

  @override
  Future<Either> getTopSelling(int limit) async {
    var response = await sl<ProductFirebaseService>().getTopSelling(limit);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<ProductEntity> products = List<ProductEntity>.from(
            data.map((e) => productToEntity(ProductModel.fromMap(e)))).toList();
        return Right(products);
      },
    );
  }

  @override
  Future<Either> getProductsByCategory(String categoryID) async {
    var response =
        await sl<ProductFirebaseService>().getProductsByCategory(categoryID);
    return response.fold(
      (error) {
        return Left(error);
        },
      (data) {
        List<ProductEntity> products = List<ProductEntity>.from(
            data.map((e) => productToEntity(ProductModel.fromMap(e)))).toList();
        return Right(products);
      },
    );
  }

  @override
  Future<Either> getProductsByName(String name) {
    // TODO: implement getProductsByName
    throw UnimplementedError();
  }
}
