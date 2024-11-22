import 'package:star_shop/features/domain/auth/entities/user_entity.dart';

class UserInfoDisplayState {}

class UserInfoLoading extends UserInfoDisplayState{}

class UserInfoLoaded extends UserInfoDisplayState{
  final UserEntity userEntity;

  UserInfoLoaded({required this.userEntity});
}

class IsAdmin extends UserInfoDisplayState{
  final UserEntity userEntity;

  IsAdmin({required this.userEntity});
}

class UserInfoLoadFailure extends UserInfoDisplayState{
  final String errorCode;

  UserInfoLoadFailure({required this.errorCode});
}

class EmailNotVerified extends UserInfoDisplayState{}

class UserInfoIsEmpty extends UserInfoDisplayState{}