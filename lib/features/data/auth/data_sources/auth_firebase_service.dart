import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/auth/models/user_sign_in_req.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_shop/features/data/auth/models/user_sign_up_req.dart';

class AuthFirebaseService {
  Future<Either> signIn(UserSignInReq user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return const Right('Login successful');
    } on FirebaseAuthException catch (e) {
      // String message = '';
      //
      // if(e.code == 'invalid-email') {
      //   message = 'Not user found for this email';
      // } else if (e.code == 'invalid-credential') {
      //   message = 'Wrong password provided for this user';
      // }

      return Left(e.code);
    }
  }

  Future<Either> signUp(UserSignUpReq user) async {
    try {
      if(user.password == user.confirmPassword){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password,
        );
        return const Right('Login successful');
      }
      return const Left('password-not-match');
    } on FirebaseAuthException catch (e) {
      // String message = '';
      //
      // if(e.code == 'invalid-email') {
      //   message = 'Not user found for this email';
      // } else if (e.code == 'invalid-credential') {
      //   message = 'Wrong password provided for this user';
      // }

      return Left(e.code);
    }
  }
}
