import 'package:star_shop/features/domain/location/entities/ward_entity.dart';

class WardDisplayState {}

class WardLoading extends WardDisplayState {}

class WardLoaded extends WardDisplayState {
  final List<WardEntity> wards;

  WardLoaded({required this.wards});
}

class WardLoadFailure extends WardDisplayState{}
