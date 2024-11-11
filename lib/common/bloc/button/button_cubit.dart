import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitialState());

  Future<void> execute({dynamic params, required UseCase useCase}) async {
    emit(ButtonLoadingState());
    try {
      var data = await useCase.call(params: params);
      data.fold(
        (error) {
          emit(ButtonFailureState(errorCode: error));
        },
        (data) {
          emit(ButtonSuccessState());
        },
      );
    } catch (e) {
      emit(ButtonFailureState(errorCode: e.toString()));
    }
  }
}
