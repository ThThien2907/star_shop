import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/category/data_sources/category_firebase_service.dart';
import 'package:star_shop/features/data/category/models/category_model.dart';
import 'package:star_shop/features/domain/category/entities/category_entity.dart';
import 'package:star_shop/features/domain/category/repositories/category_repository.dart';
import 'package:star_shop/service_locator.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<Either> getCategories() async {
    var response = await sl<CategoryFirebaseService>().getCategories();
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<CategoryEntity> categories = List<CategoryEntity>.from(data
            .map((e) => categoryToEntity(CategoryModel.fromMap(e)))
            .toList());
        return Right(categories);
      },
    );
  }

  CategoryEntity categoryToEntity(CategoryModel model) {
    return CategoryEntity(
      categoryID: model.categoryID,
      image: model.image,
      title: model.title,
    );
  }

  CategoryModel categoryToModel(CategoryEntity entity) {
    return CategoryModel(
      categoryID: entity.categoryID,
      image: entity.image,
      title: entity.title,
    );
  }

  @override
  Future<Either> addNewCategory(CategoryEntity categoryEntity) async {
    var categoryModel = categoryToModel(categoryEntity);
    return sl<CategoryFirebaseService>().addNewCategory(categoryModel);
  }

  @override
  Future<Either> updateCategory(CategoryEntity categoryEntity) async {
    var categoryModel = categoryToModel(categoryEntity);
    return sl<CategoryFirebaseService>().updateCategory(categoryModel);
  }
}
