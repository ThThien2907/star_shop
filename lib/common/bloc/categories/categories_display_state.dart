import 'package:star_shop/features/domain/category/entities/category_entity.dart';

class CategoriesDisplayState{}

class CategoriesLoaded extends CategoriesDisplayState{
  final List<CategoryEntity> categories;

  CategoriesLoaded({required this.categories});
}

class CategoriesLoading extends CategoriesDisplayState{}

class CategoriesInitialState extends CategoriesDisplayState{}

class CategoriesLoadFailure extends CategoriesDisplayState{
  final String errorCode;

  CategoriesLoadFailure({required this.errorCode});
}