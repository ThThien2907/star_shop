import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class ProductFirebaseService {
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
}
