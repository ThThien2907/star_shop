import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class CategoryFirebaseService {
  Future<Either> getCategories() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('categories')
          .get(const GetOptions(source: Source.server));
      var data = response.docs.map((e) => e.data()).toList();
      return (Right(data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
