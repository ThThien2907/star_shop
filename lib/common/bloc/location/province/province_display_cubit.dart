import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/location/province/province_display_state.dart';
import 'package:star_shop/features/domain/location/use_cases/get_all_province_uc.dart';

class ProvinceDisplayCubit extends Cubit<ProvinceDisplayState> {
  ProvinceDisplayCubit() : super(ProvinceLoading());

  Future<void> getAllProvinces() async {
    emit(ProvinceLoading());
    try {
      var response = await GetAllProvinceUc().call();
      response.fold(
        (error) {
          emit(ProvinceLoadFailure());
        },
        (data) {
          emit(ProvinceLoaded(provinces: data));
        },
      );
    } catch (e) {
      emit(ProvinceLoadFailure());
    }
  }


}
