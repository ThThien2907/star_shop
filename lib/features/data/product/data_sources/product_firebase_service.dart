import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_shop/features/data/product/models/product_model.dart';

class ProductFirebaseService {
  Future<Either> getProducts(int limit) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get(const GetOptions(source: Source.server));
      var data = response.docs.map((e) => e.data()).toList();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> getProductsByUpdatedAt(int limit) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('updatedAt', descending: true)
          .limit(limit)
          .get(const GetOptions(source: Source.server));
      var data = response.docs.map((e) => e.data()).toList();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> getTopSelling(int limit) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('salesNumber', descending: true)
          .limit(limit)
          .get(const GetOptions(source: Source.server));
      var data = response.docs.map((e) => e.data()).toList();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> getProductsByID(String productID) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('products')
          .doc(productID)
          .get(const GetOptions(source: Source.server));
      return Right(response.data());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> getProductsByCategory(String categoryID) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('products')
          .where('categoryID', isEqualTo: categoryID)
          .get(const GetOptions(source: Source.server));
      var data = response.docs.map((e) => e.data()).toList();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> getProductsByName(String name) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('title')
          .startAt([name]).endAt(['$name\uf8ff']).get(
              const GetOptions(source: Source.server));
      var data = response.docs.map((e) => e.data()).toList();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> getFavoriteProducts() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorite')
          .get(const GetOptions(source: Source.server));
      var data = response.docs.map((e) => e.data()).toList();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> addOrRemoveFavoriteProduct(ProductModel productModel) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorite')
          .where('productID', isEqualTo: productModel.productID)
          .get(const GetOptions(source: Source.server));

      if (response.docs.isNotEmpty) {
        await response.docs.first.reference.delete();
        return const Right(false);
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('favorite')
            .doc(productModel.productID)
            .set(productModel.toMap());
        return const Right(true);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> addNewProduct(ProductModel productModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productModel.productID)
          .set(productModel.toMap());
      return (const Right('Add new product successful'));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> updateProduct(ProductModel productModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productModel.productID)
          .update({
        'title': productModel.title,
        'description': productModel.description,
        'categoryID': productModel.categoryID,
        'images': productModel.images.map((e) => e.toString()).toList(),
        'price': productModel.price,
        'oldPrice': productModel.oldPrice,
        'quantityInStock': productModel.quantityInStock,
        'updatedAt': productModel.updatedAt,
      });
      return (const Right('Update product successful'));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
