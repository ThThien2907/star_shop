import 'package:star_shop/features/domain/location/entities/district_entity.dart';

class DistrictDisplayState {}

class DistrictLoading extends DistrictDisplayState{}

class DistrictLoaded extends DistrictDisplayState{
  final List<DistrictEntity> districts;

  DistrictLoaded({required this.districts});
}

class DistrictLoadFailure extends DistrictDisplayState{}