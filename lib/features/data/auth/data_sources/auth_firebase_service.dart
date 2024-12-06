import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/auth/models/user_address_model.dart';
import 'package:star_shop/features/data/auth/models/user_model.dart';
import 'package:star_shop/features/data/auth/models/user_sign_in_req.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_shop/features/data/auth/models/user_sign_up_req.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<Either> addOrUpdateProfile(UserModel user) async {
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
        var addressResponse = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('address')
            .get();
        if (addressResponse.docs.isEmpty) {
          return const Right('UserAddressIsEmpty');
        }
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

  Future<Either> getAddress(String userID) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('address')
          .get(const GetOptions(source: Source.server));

      var data = response.docs;

      if (data.isEmpty) {
        return const Right(null);
      } else {
        List<UserAddressModel> list = List.from(
            data.map((e) => UserAddressModel.fromMap(e.data())).toList());
        return Right(list);
      }
    } on FirebaseException catch (e) {
      return Left(e.message);
    }
  }

  Future<Either> addAddress(UserAddressModel address) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('address')
          .doc(address.addressId)
          .set(address.toMap());

      return const Right('Add Address Successful');
    } on FirebaseException catch (e) {
      return Left(e.message);
    }
  }

  Future<Either> updateAddress(UserAddressModel address) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('address')
          .doc(address.addressId)
          .update(address.toMap());

      return const Right('Update Address Successful');
    } on FirebaseException catch (e) {
      return Left(e.message);
    }
  }

  Future<Either> removeAddress(String addressID) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('address')
          .doc(addressID)
          .delete();

      return const Right('Remove Address Successful');
    } on FirebaseException catch (e) {
      return Left(e.message);
    }
  }

  Future<Either> setDefaultAddress(String addressID) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      var response = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('address')
          .where('isDefault', isEqualTo: true)
          .get(const GetOptions(source: Source.server));

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('address')
          .doc(response.docs.first.data()['addressId'])
          .update({
        'isDefault': false,
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('address')
          .doc(addressID)
          .update({
        'isDefault': true,
      });

      return const Right('Set Default Address Successful');
    } on FirebaseException catch (e) {
      return Left(e.message);
    }
  }
}
