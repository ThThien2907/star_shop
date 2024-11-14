import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/location/data_sources/api_location_service.dart';
import 'package:star_shop/features/data/location/models/district_model.dart';
import 'package:star_shop/features/data/location/models/province_model.dart';
import 'package:star_shop/features/data/location/models/ward_model.dart';
import 'package:star_shop/features/domain/location/entities/district_entity.dart';
import 'package:star_shop/features/domain/location/entities/province_entity.dart';
import 'package:star_shop/features/domain/location/entities/ward_entity.dart';
import 'package:star_shop/features/domain/location/repositories/location_repository.dart';
import 'package:star_shop/service_locator.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  @override
  Future<Either> getAllProvince() async {
    var response = await sl<ApiLocationService>().getAllProvince();
    return response.fold(
      (error) {
        return Left(error.toString());
      },
      (data) {
        List<ProvinceEntity> provinces = List<ProvinceEntity>.from(
            data.map((x) => provinceToEntity(x)).toList());
        return Right(provinces);
      },
    );
  }

  ProvinceEntity provinceToEntity(ProvinceModel model) {
    return ProvinceEntity(
      name_with_type: model.name_with_type,
      code: model.code,
      isDeleted: model.isDeleted,
    );
  }

  @override
  Future<Either> getDistrictByProvince(String code) async {
    var response = await sl<ApiLocationService>().getDistrictByProvince(code);
    return response.fold(
      (error) {
        return Left(error.toString());
      },
      (data) {
        List<DistrictEntity> districts = List<DistrictEntity>.from(
            data.map((x) => districtToEntity(x)).toList());
        return Right(districts);
      },
    );
  }

  DistrictEntity districtToEntity(DistrictModel model) {
    return DistrictEntity(
      name_with_type: model.name_with_type,
      code: model.code,
      parent_code: model.parent_code,
      isDeleted: model.isDeleted,
    );
  }

  @override
  Future<Either> getWardByDistrict(String code) async {
    var response = await sl<ApiLocationService>().getWardByDistrict(code);
    return response.fold(
          (error) {
        return Left(error.toString());
      },
          (data) {
        List<WardEntity> wards = List<WardEntity>.from(
            data.map((x) => wardToEntity(x)).toList());
        return Right(wards);
      },
    );
  }

  WardEntity wardToEntity(WardModel model) {
    return WardEntity(
      name_with_type: model.name_with_type,
      code: model.code,
      parent_code: model.parent_code,
      isDeleted: model.isDeleted,
    );
  }
}
