import 'package:dartz/dartz.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/domain/product/repositories/product_repository.dart';
import 'package:star_shop/service_locator.dart';

class UpdateProductUseCase extends UseCase<Either, ProductEntity>{
  @override
  Future<Either> call({ProductEntity? params}) async {

    return await sl<ProductRepository>().updateProduct(params!);
  }

}