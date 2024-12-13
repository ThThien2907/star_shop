import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_shop/features/data/order/models/order_model.dart';
import 'package:star_shop/features/data/order/models/product_ordered_model.dart';

class OrderFirebaseService {
  Future<Either> addProductToCart(
      ProductOrderedModel productOrderedModel) async {
    try {
      var quantityInStock =
          await getProductQuantity(productOrderedModel.productID);

      if (productOrderedModel.quantity <= quantityInStock) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart')
            .doc(productOrderedModel.productID)
            .set(productOrderedModel.toMap());
        return const Right('Add product successful');
      } else {
        return const Left('The quantity exceeds the quantity in stock!');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> getProductsFromCart() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .get(const GetOptions(source: Source.server));
      var data = response.docs.map((e) => e.data()).toList();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> removeProductFromCart(String productID) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(productID)
          .delete();
      return const Right('Remove product successful');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> updateProductOrderedQuantity(
      String productID, num quantity, num totalPrice) async {
    try {
      var quantityInStock = await getProductQuantity(productID);

      if (quantity <= quantityInStock) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart')
            .doc(productID)
            .update({'quantity': quantity, 'totalPrice': totalPrice});
        return const Right('Update product quantity successful');
      } else {
        return const Left('The quantity exceeds the quantity in stock!');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<num> getProductQuantity(String productID) async {
    var response = await FirebaseFirestore.instance
        .collection('products')
        .doc(productID)
        .get(const GetOptions(source: Source.server));

    return response.data()!['quantityInStock'];
  }

  Future<Either> placeOrder(OrderModel orderModel) async {
    try {
      for (var i in orderModel.productsOrdered) {
        num quantityInStock = await getProductQuantity(i.productID);
        num quantityAfterOrder = quantityInStock - i.quantity;
        if (quantityAfterOrder < 0) {
          return Left(
              'The quantity of product ${i.title} is not enough to place an order');
        }
      }

      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderModel.orderID)
          .set(orderModel.toMap());

      for (var i in orderModel.productsOrdered) {
        num quantityInStock = await getProductQuantity(i.productID);
        num quantityAfterOrder = quantityInStock - i.quantity;

        await FirebaseFirestore.instance
            .collection('products')
            .doc(i.productID)
            .update({'quantityInStock': quantityAfterOrder});
        await FirebaseFirestore.instance
            .collection('users')
            .doc(orderModel.userId)
            .collection('cart')
            .doc(i.productID)
            .delete();
      }

      return const Right('Place Order Successful');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> getOrderByUid() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get(const GetOptions(source: Source.server));

      var data = response.docs.map((e) => e.data()).toList();
      List<OrderModel> listOrder =
          List.from(data.map((e) => OrderModel.fromMap(e)).toList());

      return Right(listOrder);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
