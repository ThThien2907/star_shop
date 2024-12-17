import 'package:dartz/dartz.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';

abstract class ProductRepository{
  Future<Either> getProducts(int limit);
  Future<Either> getProductsByUpdatedAt(int limit);
  Future<Either> getTopSelling(int limit);
  Future<Either> getProductsByCategory(String categoryID);
  Future<Either> getProductsByName(String name);
  Future<Either> getFavoriteProducts();
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity productEntity);

  Future<Either> addNewProduct(ProductEntity productEntity);
  Future<Either> updateProduct(ProductEntity productEntity);

}