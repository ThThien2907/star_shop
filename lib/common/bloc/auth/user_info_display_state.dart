import 'package:star_shop/features/domain/auth/entities/user_entity.dart';

class UserInfoDisplayState {}

class UserInfoDisplayLoading extends UserInfoDisplayState{}

class UserInfoDisplayLoaded extends UserInfoDisplayState{
  final UserEntity userEntity;

  UserInfoDisplayLoaded({required this.userEntity});
}

class UserInfoDisplayLoadFailure extends UserInfoDisplayState{
  final String errorCode;

  UserInfoDisplayLoadFailure({required this.errorCode});
}

class EmailNotVerified extends UserInfoDisplayState{}

class UserInfoEmpty extends UserInfoDisplayState{}