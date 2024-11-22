import 'package:dartz/dartz.dart';

abstract class ProductRepository{
  Future<Either> getTopSelling(int limit);
  Future<Either> getProductsByCategory(String categoryID);
  Future<Either> getProductsByName(String name);
}