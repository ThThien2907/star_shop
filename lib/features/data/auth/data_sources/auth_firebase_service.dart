import 'package:dartz/dartz.dart';
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
        var response =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password,
        );
        // UserModel userModel = UserModel(
        //   userId: response.user!.uid,
        //   fullName: '',
        //   email: user.email,
        //   dob: '',
        //   phoneNumber: '',
        //   address: '',
        //   city: '',
        //   district: '',
        //   ward: '',
        //   gender: '',
        //   role: 'UR',
        // );
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(response.user!.uid)
        //     .set(userModel.toMap());
        return const Right('successful');
      }
      return const Left('password-not-match');
    } on FirebaseException catch (e) {
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
      var response = await FirebaseFirestore.instance.collection('users').doc(user.userId).get();
      if (response.data() == null){
        print('set');
        await FirebaseFirestore.instance
            .collection('users')
        // .doc(FirebaseAuth.instance.currentUser!.uid)
            .doc(user.userId)
            .set(user.toMap());
      }
      else {
        print('update');
        await FirebaseFirestore.instance
            .collection('users')
        // .doc(FirebaseAuth.instance.currentUser!.uid)
            .doc(user.userId)
            .update(user.toMap());
      }
      return const Right('Update Success');
    } on FirebaseException catch (e) {
      return Left(e.code);
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
      return Left(e.code);
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
}
