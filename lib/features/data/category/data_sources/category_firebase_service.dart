import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/category/models/category_model.dart';

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

  Future<Either> addNewCategory(CategoryModel categoryModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryModel.categoryID).set(categoryModel.toMap());
      return (const Right('Add new category successful'));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either> updateCategory(CategoryModel categoryModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryModel.categoryID).update(categoryModel.toMap());
      return (const Right('Update category successful'));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
