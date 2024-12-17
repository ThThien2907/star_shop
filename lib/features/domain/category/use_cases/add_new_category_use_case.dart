import 'package:dartz/dartz.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/category/entities/category_entity.dart';
import 'package:star_shop/features/domain/category/repositories/category_repository.dart';
import 'package:star_shop/service_locator.dart';

class AddNewCategoryUseCase extends UseCase<Either, CategoryEntity>{
  @override
  Future<Either> call({CategoryEntity? params}) async {
    return sl<CategoryRepository>().addNewCategory(params!);
  }

}