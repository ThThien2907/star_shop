import 'package:star_shop/features/domain/auth/entities/user_address_entity.dart';

class AddressDisplayState {}

class AddressDisplayInitialState extends AddressDisplayState{}

class AddressDisplayLoading extends AddressDisplayState{}

class AddressDisplayLoadFailure extends AddressDisplayState{
  final String error;

  AddressDisplayLoadFailure({required this.error});
}

class AddressDisplayLoaded extends AddressDisplayState{
  final List<UserAddressEntity> list;

  AddressDisplayLoaded({required this.list});
}