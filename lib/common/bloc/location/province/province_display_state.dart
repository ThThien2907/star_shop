import 'package:star_shop/features/domain/location/entities/province_entity.dart';

class ProvinceDisplayState{}

class ProvinceLoading extends ProvinceDisplayState{}
class ProvinceLoaded extends ProvinceDisplayState{
  final List<ProvinceEntity> provinces;

  ProvinceLoaded({required this.provinces});
}
class ProvinceLoadFailure extends ProvinceDisplayState{}

class DisplayProvince extends ProvinceDisplayState{}