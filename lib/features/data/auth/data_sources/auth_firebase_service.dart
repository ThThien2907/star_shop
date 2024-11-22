import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/auth/models/user_model.dart';
import 'package:star_shop/features/data/auth/models/user_sign_in_req.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_shop/features/data/auth/models/user_sign_up_req.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:star_shop/features/data/product/models/product_model.dart';

class AuthFirebaseService {
  Future<Either> signIn(UserSignInReq user) async {
    try {
      var response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return Right(response.user!.uid);
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

  Future<Either> signUp(UserSignUpReq user) async {
    try {
      if (user.password == user.confirmPassword) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password,
        );
        return const Right('Successful');
      }
      return const Left('password-not-match');
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }
    return false;
  }

  Future<Either> updateProfile(UserModel user) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.userId)
          .get();
      if (response.data() == null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.userId)
            .set(user.toMap());
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.userId)
            .update(user.toMap());
      }
      return const Right('Update Successful');
    } on FirebaseException catch (e) {
      return Left(e.message);
    }
  }

  Future<Either> getUser(String uid) async {
    try {
      var response =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (response.data() != null) {
        UserModel userModel = UserModel.fromMap(response.data()!);
        return Right(userModel);
      } else {
        return const Right(null);
      }
    } on FirebaseException catch (e) {
      return Left(e.message);
    }
  }

  Future<Either> sendEmailVerifyEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return const Right('Email was sent');
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

  Future<Either> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right('Email was sent');
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

// Future<Either> setCate(String title, String image, String id) async {
//   try {
//     var response = await FirebaseFirestore.instance.collection('categories').doc(id).set({
//       'title' : title,
//       'categoryID' : id,
//       'image' : image
//     });
//     return const Right('Update Success');
//   } on FirebaseException catch (e) {
//     return Left(e.code);
//   }
// }
  Future<Either> setPro(ProductModel pro) async {
    try {
      var response = await FirebaseFirestore.instance.collection('products').doc(pro.productID).set(pro.toMap());
      // print(response.data().toString());
      return const Right('Update Success');
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }
}
