import 'package:dartz/dartz.dart';
import 'package:star_shop/features/domain/category/entities/category_entity.dart';

abstract class CategoryRepository{
  Future<Either> getCategories();


  Future<Either> addNewCategory(CategoryEntity categoryEntity);
  Future<Either> updateCategory(CategoryEntity categoryEntity);
}