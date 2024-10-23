import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/auth/models/user_sign_in_req.dart';

abstract class AuthRepository {
  Future<Either> signIn(UserSignInReq user);
  Future<Either> signUp();
}