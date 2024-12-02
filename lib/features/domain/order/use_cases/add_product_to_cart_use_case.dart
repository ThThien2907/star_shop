import 'package:dartz/dartz.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';
import 'package:star_shop/features/domain/order/repositories/order_repository.dart';
import 'package:star_shop/service_locator.dart';

class AddProductToCartUseCase extends UseCase<Either, ProductOrderedEntity>{
  @override
  Future<Either> call({ProductOrderedEntity? params}) async {
    return await sl<OrderRepository>().addProductToCart(params!);
  }
}