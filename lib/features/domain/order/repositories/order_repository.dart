import 'package:dartz/dartz.dart';
import 'package:star_shop/features/domain/order/entities/order_entity.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';

abstract class OrderRepository{
  Future<Either> getProductsFromCart();
  Future<Either> addProductToCart(ProductOrderedEntity entity);
  Future<Either> removeProductFromCart(String productID);
  Future<Either> updateProductOrderedQuantity(String productID, num quantity, num totalPrice);

  Future<Either> placeOrder(OrderEntity orderEntity);
  Future<Either> getOrderByUid();
}