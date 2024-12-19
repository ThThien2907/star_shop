import 'package:dartz/dartz.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/order/entities/order_entity.dart';
import 'package:star_shop/features/domain/order/repositories/order_repository.dart';
import 'package:star_shop/service_locator.dart';

class CompleteOrderUseCase extends UseCase<Either, OrderEntity>{
  @override
  Future<Either> call({OrderEntity? params}) async {
    return await sl<OrderRepository>().completeOrder(params!);
  }

}