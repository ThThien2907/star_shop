import 'package:dartz/dartz.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/order/repositories/order_repository.dart';
import 'package:star_shop/service_locator.dart';

class GetProductsFromCartUseCase extends UseCase<Either, dynamic>{
  @override
  Future<Either> call({params}) async {
    return await sl<OrderRepository>().getProductsFromCart();
  }
}