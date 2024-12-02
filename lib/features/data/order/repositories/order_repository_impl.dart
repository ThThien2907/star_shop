import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/order/data_sources/order_firebase_service.dart';
import 'package:star_shop/features/data/order/models/product_ordered_model.dart';
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
        List<ProductOrderedEntity> products = List<ProductOrderedEntity>.from(data.map((e) => productOrderedToEntity(ProductOrderedModel.fromMap(e))).toList());
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
      oldPrice: model.oldPrice,
      totalPrice: model.totalPrice,
      images: model.images,
      quantityInStock: model.quantityInStock,
      quantity: model.quantity,
    );
  }

  ProductOrderedModel productOrderedToModel(ProductOrderedEntity entity) {
    return ProductOrderedModel(
      productID: entity.productID,
      title: entity.title,
      price: entity.price,
      oldPrice: entity.oldPrice,
      totalPrice: entity.totalPrice,
      images: entity.images,
      quantityInStock: entity.quantityInStock,
      quantity: entity.quantity,
    );
  }

  @override
  Future<Either> updateProductOrderedQuantity(String productID, num quantity, num totalPrice) async {
    return await sl<OrderFirebaseService>().updateProductOrderedQuantity(productID, quantity, totalPrice);
  }
}
