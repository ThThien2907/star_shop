import 'package:dartz/dartz.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/product/repositories/product_repository.dart';
import 'package:star_shop/service_locator.dart';

class GetFavoriteProductsUseCase extends UseCase<Either, dynamic>{
  @override
  Future<Either> call({params}) async {
    return await sl<ProductRepository>().getFavoriteProducts();
  }
}