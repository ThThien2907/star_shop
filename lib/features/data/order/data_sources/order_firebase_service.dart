import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_shop/features/data/order/models/product_ordered_model.dart';

class OrderFirebaseService {
  Future<Either> addProductToCart(
      ProductOrderedModel productOrderedModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(productOrderedModel.productID)
          .set(productOrderedModel.toMap());
      return const Right('Add product successful');
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
    // num totalPrice = quantity * price;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(productID)
          .update({'quantity': quantity, 'totalPrice': totalPrice});
      return const Right('Update product quantity successful');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
