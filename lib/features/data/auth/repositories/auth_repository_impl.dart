import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/auth/data_sources/auth_firebase_service.dart';
import 'package:star_shop/features/data/auth/models/user_model.dart';
import 'package:star_shop/features/data/auth/models/user_sign_in_req.dart';
import 'package:star_shop/features/data/auth/models/user_sign_up_req.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';
import 'package:star_shop/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signIn(UserSignInReq user) async {
    return await sl<AuthFirebaseService>().signIn(user);
  }

  @override
  Future<Either> signUp(UserSignUpReq user) async {
    return await sl<AuthFirebaseService>().signUp(user);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthFirebaseService>().isLoggedIn();
  }

  @override
  Future<Either> updateProfile(UserEntity user) async {
    var userModel = userToModel(user);
    var response = await sl<AuthFirebaseService>().updateProfile(userModel);
    return response.fold(
      (error) {
        return Left(error.toString());
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> getUser(String uid) async {
    var response = await sl<AuthFirebaseService>().getUser(uid);
    return response.fold((error){
      return Left(error);
    }, (data){
      if (data == null){
        return Right(null);
      }
      UserEntity userEntity = userToEntity(data);
      return Right(userEntity);
    },);
  }



  UserModel userToModel(UserEntity user) {
    return UserModel(
      userId: user.userId,
      fullName: user.fullName,
      email: user.email,
      dob: user.dob,
      phoneNumber: user.phoneNumber,
      address: user.address,
      city: user.city,
      district: user.district,
      ward: user.ward,
      gender: user.gender,
      role: user.role,
    );
  }

  UserEntity userToEntity(UserModel user) {
    return UserEntity(
      userId: user.userId!,
      fullName: user.fullName!,
      email: user.email!,
      dob: user.dob!,
      phoneNumber: user.phoneNumber!,
      address: user.address!,
      city: user.city!,
      district: user.district!,
      ward: user.ward!,
      gender: user.gender!,
      role: user.role!,
    );
  }

  @override
  Future<Either> sendEmailVerifyEmail() async{
    return await sl<AuthFirebaseService>().sendEmailVerifyEmail();
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async{
    return await sl<AuthFirebaseService>().sendPasswordResetEmail(email);
  }
}
