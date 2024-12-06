import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/auth/data_sources/auth_firebase_service.dart';
import 'package:star_shop/features/data/auth/models/user_address_model.dart';
import 'package:star_shop/features/data/auth/models/user_model.dart';
import 'package:star_shop/features/data/auth/models/user_sign_in_req.dart';
import 'package:star_shop/features/data/auth/models/user_sign_up_req.dart';
import 'package:star_shop/features/domain/auth/entities/user_address_entity.dart';
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
  Future<Either> addOrUpdateProfile(UserEntity user) async {
    var userModel = userToModel(user);
    var response = await sl<AuthFirebaseService>().addOrUpdateProfile(userModel);
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
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) {
        if (data == null) {
          return const Right(null);
        }
        if (data == 'UserAddressIsEmpty') {
          return const Right('UserAddressIsEmpty');
        }
        UserEntity userEntity = userToEntity(data);
        return Right(userEntity);
      },
    );
  }

  UserModel userToModel(UserEntity user) {
    return UserModel(
      userId: user.userId,
      fullName: user.fullName,
      email: user.email,
      dob: user.dob,
      phoneNumber: user.phoneNumber,
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
      gender: user.gender!,
      role: user.role!,
    );
  }

  UserAddressModel userAddressToModel(UserAddressEntity user) {
    return UserAddressModel(
      addressId: user.addressId!,
      addressName: user.addressName!,
      detailedAddress: user.detailedAddress!,
      city: user.city!,
      cityCode: user.cityCode!,
      district: user.district!,
      districtCode: user.districtCode!,
      ward: user.ward!,
      isDefault: user.isDefault!,
    );
  }

  UserAddressEntity userAddressToEntity(UserAddressModel user) {
    return UserAddressEntity(
      addressId: user.addressId,
      addressName: user.addressName,
      detailedAddress: user.detailedAddress,
      city: user.city,
      cityCode: user.cityCode,
      district: user.district,
      districtCode: user.districtCode,
      ward: user.ward,
      isDefault: user.isDefault,
    );
  }

  @override
  Future<Either> sendEmailVerifyEmail() async {
    return await sl<AuthFirebaseService>().sendEmailVerifyEmail();
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    return await sl<AuthFirebaseService>().sendPasswordResetEmail(email);
  }

  @override
  Future<Either> updateAddress(UserAddressEntity address) async {
    var addressModel = userAddressToModel(address);
    var response = await sl<AuthFirebaseService>().updateAddress(addressModel);
    return response.fold(
          (error) {
        return Left(error);
      },
          (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> addAddress(UserAddressEntity address) async {
    var addressModel = userAddressToModel(address);
    var response = await sl<AuthFirebaseService>().addAddress(addressModel);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> removeAddress(String addressId) async{
    return await sl<AuthFirebaseService>().removeAddress(addressId);
  }

  @override
  Future<Either> getAddress(String userID) async {
    var response = await sl<AuthFirebaseService>().getAddress(userID);

    return response.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<UserAddressEntity> list = List.from(
            data.map((e) => userAddressToEntity(e)).toList());
        return Right(list);
      },
    );
  }

  @override
  Future<Either> setDefaultAddress(String addressId) async{
    return await sl<AuthFirebaseService>().setDefaultAddress(addressId);
  }
}
