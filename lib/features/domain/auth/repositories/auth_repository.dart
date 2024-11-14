import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/auth/models/user_sign_in_req.dart';
import 'package:star_shop/features/data/auth/models/user_sign_up_req.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either> signIn(UserSignInReq user);
  Future<Either> signUp(UserSignUpReq user);
  Future<bool> isLoggedIn();
  Future<Either> updateProfile(UserEntity user);
  Future<Either> getUser(String uid);
}