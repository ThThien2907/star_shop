import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/location/district/district_display_state.dart';
import 'package:star_shop/features/domain/location/use_cases/get_district_by_province_uc.dart';

class DistrictDisplayCubit extends Cubit<DistrictDisplayState>{
  DistrictDisplayCubit() : super(DistrictLoading());

  Future<void> getDistrictByProvince(String code) async {
    emit(DistrictLoading());
    try {
      var response = await GetDistrictByProvinceUc().call(params: code);
      response.fold(
            (error) {
          emit(DistrictLoadFailure());
        },
            (data) {
          emit(DistrictLoaded(districts: data));
        },
      );
    } catch (e) {
      emit(DistrictLoadFailure());
    }
  }
}