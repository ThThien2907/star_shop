import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/auth/data_sources/auth_firebase_service.dart';
import 'package:star_shop/features/data/auth/models/user_sign_in_req.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';
import 'package:star_shop/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository{

  @override
  Future<Either> signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Either> signIn(UserSignInReq user) {
    return sl<AuthFirebaseService>().signIn(user);
  }

}