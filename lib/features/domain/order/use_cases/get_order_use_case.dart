import 'package:dartz/dartz.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/order/repositories/order_repository.dart';
import 'package:star_shop/service_locator.dart';

class GetOrderUseCase extends UseCase<Either, bool>{
  @override
  Future<Either> call({bool? params}) async {
    return sl<OrderRepository>().getOrder(params!);
  }
}