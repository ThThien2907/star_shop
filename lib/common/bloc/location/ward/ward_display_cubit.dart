import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/location/ward/ward_display_state.dart';
import 'package:star_shop/features/domain/location/use_cases/get_ward_by_district_uc.dart';

class WardDisplayCubit extends Cubit<WardDisplayState>{
  WardDisplayCubit() : super(WardLoading());

  Future<void> getWardByDistrict(String code) async {
    emit(WardLoading());
    try {
      var response = await GetWardByDistrictUc().call(params: code);
      response.fold(
            (error) {
          emit(WardLoadFailure());
        },
            (data) {
          emit(WardLoaded(wards: data));
        },
      );
    } catch (e) {
      emit(WardLoadFailure());
    }
  }
}