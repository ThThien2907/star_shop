import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:star_shop/features/data/location/models/district_model.dart';
import 'package:star_shop/features/data/location/models/province_model.dart';
import 'package:star_shop/features/data/location/models/ward_model.dart';

class ApiLocationService {
  var dio = Dio();

  Future<Either> getAllProvince() async {
    try{
      final response = await dio.get('https://vn-public-apis.fpo.vn/provinces/getAll?limit=-1');
      var data = response.data['data']['data'];
      List<ProvinceModel> provinces = List<ProvinceModel>.from(data.map((x) => ProvinceModel.fromMap(x)).toList());
      return Right(provinces);
    }
    catch(e){
      return Left(e.toString());
    }
  }

  Future<Either> getDistrictByProvince(String code) async {
    try{
      final response = await dio.get('https://vn-public-apis.fpo.vn/districts/getByProvince?provinceCode=$code&limit=-1');
      var data = response.data['data']['data'];
      List<DistrictModel> districts = List<DistrictModel>.from(data.map((x) => DistrictModel.fromMap(x)).toList());
      return Right(districts);
    }
    catch(e){
      return Left(e.toString());
    }
  }

  Future<Either> getWardByDistrict(String code) async {
    try{
      final response = await dio.get('https://vn-public-apis.fpo.vn/wards/getByDistrict?districtCode=$code&limit=-1');
      var data = response.data['data']['data'];
      List<WardModel> wards = List<WardModel>.from(data.map((x) => WardModel.fromMap(x)).toList());
      return Right(wards);
    }
    catch(e){
      return Left(e.toString());
    }
  }
}