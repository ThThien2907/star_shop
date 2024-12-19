import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/order/data_sources/order_firebase_service.dart';
import 'package:star_shop/features/data/order/models/order_model.dart';
import 'package:star_shop/features/data/order/models/product_ordered_model.dart';
import 'package:star_shop/features/domain/order/entities/order_entity.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';
import 'package:star_shop/features/domain/order/repositories/order_repository.dart';
import 'package:star_shop/service_locator.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<Either> addProductToCart(ProductOrderedEntity entity) async {
    var model = productOrderedToModel(entity);
    return await sl<OrderFirebaseService>().addProductToCart(model);
  }

  @override
  Future<Either> getProductsFromCart() async {
    var response = await sl<OrderFirebaseService>().getProductsFromCart();

    return response.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<ProductOrderedEntity> products = List<ProductOrderedEntity>.from(
            data
                .map((e) =>
                    productOrderedToEntity(ProductOrderedModel.fromMap(e)))
                .toList());
        return Right(products);
      },
    );
  }

  @override
  Future<Either> removeProductFromCart(String productID) async {
    return await sl<OrderFirebaseService>().removeProductFromCart(productID);
  }

  ProductOrderedEntity productOrderedToEntity(ProductOrderedModel model) {
    return ProductOrderedEntity(
      productID: model.productID,
      title: model.title,
      price: model.price,
      totalPrice: model.totalPrice,
      images: model.images,
      quantity: model.quantity,
    );
  }

  ProductOrderedModel productOrderedToModel(ProductOrderedEntity entity) {
    return ProductOrderedModel(
      productID: entity.productID,
      title: entity.title,
      price: entity.price,
      totalPrice: entity.totalPrice,
      images: entity.images,
      quantity: entity.quantity,
    );
  }

  OrderModel orderToModel(OrderEntity entity) {
    return OrderModel(
      orderID: entity.orderID,
      userId: entity.userId,
      status: entity.status,
      totalPrice: entity.totalPrice,
      deliveryFee: entity.deliveryFee,
      productsOrdered: List.from(
          entity.productsOrdered.map((e) => productOrderedToModel(e)).toList()),

      detailedAddress: entity.detailedAddress,
      ward: entity.ward,
      district: entity.district,
      city: entity.city,
      cityCode: entity.cityCode,
      districtCode: entity.districtCode,
      createdAt: entity.createdAt,
    );
  }

  OrderEntity orderToEntity(OrderModel model) {
    return OrderEntity(
      orderID: model.orderID,
      userId: model.userId,
      status: model.status,
      totalPrice: model.totalPrice,
      deliveryFee: model.deliveryFee,
      productsOrdered: List.from(
          model.productsOrdered.map((e) => productOrderedToEntity(e)).toList()),

      detailedAddress: model.detailedAddress,
      ward: model.ward,
      district: model.district,
      city: model.city,
      cityCode: model.cityCode,
      districtCode: model.districtCode,
      createdAt: model.createdAt,
    );
  }

  @override
  Future<Either> updateProductOrderedQuantity(
      String productID, num quantity, num totalPrice) async {
    return await sl<OrderFirebaseService>()
        .updateProductOrderedQuantity(productID, quantity, totalPrice);
  }

  @override
  Future<Either> placeOrder(OrderEntity orderEntity) async {
    var orderModel = orderToModel(orderEntity);
    return await sl<OrderFirebaseService>().placeOrder(orderModel);
  }

  @override
  Future<Either> getOrder(bool isGetAll) async {
    var response = await sl<OrderFirebaseService>().getOrder(isGetAll);

    return response.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<OrderEntity> listOrder = List.from(data.map((e) => orderToEntity(e)).toList());
        return Right(listOrder);
      },
    );
  }

  @override
  Future<Either> cancelOrder(OrderEntity orderEntity) async {
    var orderModel = orderToModel(orderEntity);

    return await sl<OrderFirebaseService>().cancelOrder(orderModel);
  }

  @override
  Future<Either> completeOrder(OrderEntity orderEntity) async {
    var orderModel = orderToModel(orderEntity);

    return await sl<OrderFirebaseService>().completeOrder(orderModel);
  }

  @override
  Future<Either> confirmOrder(OrderEntity orderEntity) async {
    var orderModel = orderToModel(orderEntity);

    return await sl<OrderFirebaseService>().confirmOrder(orderModel);
  }
}
