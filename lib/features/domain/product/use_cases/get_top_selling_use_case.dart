import 'package:dartz/dartz.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/product/repositories/product_repository.dart';
import 'package:star_shop/service_locator.dart';

class GetTopSellingUseCase extends UseCase<Either, int>{
  @override
  Future<Either> call({int? params}) async {
    return await sl<ProductRepository>().getTopSelling(params!);
  }

}