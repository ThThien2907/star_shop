import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/auth/data_sources/auth_firebase_service.dart';
import 'package:star_shop/features/data/auth/models/user_sign_in_req.dart';
import 'package:star_shop/features/data/auth/models/user_sign_up_req.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';
import 'package:star_shop/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository{
  @override
  Future<Either> signIn(UserSignInReq user) async{
    return await sl<AuthFirebaseService>().signIn(user);
  }

  @override
  Future<Either> signUp(UserSignUpReq user) async{
    return await sl<AuthFirebaseService>().signUp(user);
  }

}