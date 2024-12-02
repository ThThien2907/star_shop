import 'package:dartz/dartz.dart';
import 'package:star_shop/features/domain/order/repositories/order_repository.dart';
import 'package:star_shop/service_locator.dart';

class UpdateProductOrderedQuantityUseCase {
  Future<Either> call({required String productID, required num quantity, required num totalPrice}) async {
    return await sl<OrderRepository>().updateProductOrderedQuantity(productID, quantity, totalPrice);
  }
}