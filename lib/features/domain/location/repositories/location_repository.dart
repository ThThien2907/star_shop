import 'package:dartz/dartz.dart';

abstract class LocationRepository {
  Future<Either> getAllProvince();
  Future<Either> getDistrictByProvince(String code);
  Future<Either> getWardByDistrict(String code);
}