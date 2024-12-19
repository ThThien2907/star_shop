import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_shop/common/constant/app_const.dart';
import 'package:star_shop/features/data/notification/model/notification_model.dart';
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

      var notification = NotificationModel(
          notificationID: AppConst.generateRandomString(20),
          title: 'Place Order',
          message: 'The order ${orderModel.orderID} has been placed, check your order now',
          userId: 'admin',
          isRead: false,
          createdAt: Timestamp.fromDate(DateTime.now()));
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notification.notificationID)
          .set(notification.toMap());

      return const Right('Place Order Successful');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> getOrder(bool isGetAll) async {
    try {
      if (isGetAll) {
        var response = await FirebaseFirestore.instance
            .collection('orders')
            .get(const GetOptions(source: Source.server));

        var data = response.docs.map((e) => e.data()).toList();
        List<OrderModel> listOrder =
            List.from(data.map((e) => OrderModel.fromMap(e)).toList());
        return Right(listOrder);
      } else {
        var response = await FirebaseFirestore.instance
            .collection('orders')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get(const GetOptions(source: Source.server));

        var data = response.docs.map((e) => e.data()).toList();
        List<OrderModel> listOrder =
            List.from(data.map((e) => OrderModel.fromMap(e)).toList());
        return Right(listOrder);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> cancelOrder(OrderModel orderModel) async {
    try {
      for (var i in orderModel.productsOrdered) {
        var response = await FirebaseFirestore.instance
            .collection('products')
            .doc(i.productID)
            .get(const GetOptions(source: Source.server));

        num quantity = response.data()!['quantityInStock'];

        await FirebaseFirestore.instance
            .collection('products')
            .doc(i.productID)
            .update({'quantityInStock': i.quantity + quantity});
      }

      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderModel.orderID)
          .update({'status': 'Canceled'});

      var notification = NotificationModel(
          notificationID: AppConst.generateRandomString(20),
          title: 'Canceled Order',
          message: 'Your order has been canceled',
          userId: orderModel.userId,
          isRead: false,
          createdAt: Timestamp.fromDate(DateTime.now()));
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notification.notificationID)
          .set(notification.toMap());

      return const Right('Cancel order successful');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> confirmOrder(OrderModel orderModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderModel.orderID)
          .update({'status': 'Ongoing'});

      var notification = NotificationModel(
          notificationID: AppConst.generateRandomString(20),
          title: 'Confirm Order',
          message: 'Your order has been confirmed and is being shipped',
          userId: orderModel.userId,
          isRead: false,
          createdAt: Timestamp.fromDate(DateTime.now()));
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notification.notificationID)
          .set(notification.toMap());

      return const Right('Confirm order successful');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> completeOrder(OrderModel orderModel) async {
    try {
      for (var i in orderModel.productsOrdered) {
        var response = await FirebaseFirestore.instance
            .collection('products')
            .doc(i.productID)
            .get(const GetOptions(source: Source.server));

        num salesNumber = response.data()!['salesNumber'];

        await FirebaseFirestore.instance
            .collection('products')
            .doc(i.productID)
            .update({'salesNumber': i.quantity + salesNumber});
      }

      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderModel.orderID)
          .update({'status': 'Complete'});

      var notification = NotificationModel(
          notificationID: AppConst.generateRandomString(20),
          title: 'Complete Order',
          message: 'Your order has been delivered successfully',
          userId: orderModel.userId,
          isRead: false,
          createdAt: Timestamp.fromDate(DateTime.now()));
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notification.notificationID)
          .set(notification.toMap());

      return const Right('Complete order successful');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
