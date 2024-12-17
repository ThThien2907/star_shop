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
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  ProductModel productToModel(ProductEntity entity) {
    return ProductModel(
      productID: entity.productID,
      title: entity.title,
      description: entity.description,
      categoryID: entity.categoryID,
      price: entity.price,
      oldPrice: entity.oldPrice,
      images: entity.images,
      quantityInStock: entity.quantityInStock,
      salesNumber: entity.salesNumber,
      rating: entity.rating,
      reviews: entity.reviews.map((e) => reviewToModel(e)).toList(),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
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

  ReviewModel reviewToModel(ReviewEntity entity) {
    return ReviewModel(
      userId: entity.userId,
      userName: entity.userName,
      reviewId: entity.reviewId,
      rating: entity.rating,
      review: entity.review,
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
  Future<Either> getProductsByName(String name) async {
    var response = await sl<ProductFirebaseService>().getProductsByName(name);

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
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity productEntity) async {
    ProductModel productModel = productToModel(productEntity);

    var response = await sl<ProductFirebaseService>()
        .addOrRemoveFavoriteProduct(productModel);

    return response.fold(
      (error) {
        return Left(error);
      },
      (data) {
        if(data){
          return const Right(true);
        }
        else{
          return const Right(false);
        }
      },
    );
  }

  @override
  Future<Either> getFavoriteProducts() async {
    var response = await sl<ProductFirebaseService>().getFavoriteProducts();

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
  Future<Either> getProducts(int limit) async {
    var response = await sl<ProductFirebaseService>().getProducts(limit);

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
  Future<Either> getProductsByUpdatedAt(int limit) async {
    var response = await sl<ProductFirebaseService>().getProductsByUpdatedAt(limit);

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
  Future<Either> addNewProduct(ProductEntity productEntity) async {
    var productModel = productToModel(productEntity);

    return await sl<ProductFirebaseService>().addNewProduct(productModel);
  }

  @override
  Future<Either> updateProduct(ProductEntity productEntity) async {
    var productModel = productToModel(productEntity);

    return await sl<ProductFirebaseService>().updateProduct(productModel);
  }
}
