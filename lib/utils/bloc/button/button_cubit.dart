import 'package:star_shop/utils/bloc/button/button_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/utils/use_case/use_case.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitialState());

  Future<void> execute({dynamic params/*, required UseCase useCase*/}) async {
    emit(ButtonLoadingState());
    // try {
    //   var data = await useCase.call(params: params);
    //   data.fold(
    //     (error) {
    //       emit(ButtonFailureState(error: error));
    //     },
    //     (data) {
    //       emit(ButtonSuccessState());
    //     },
    //   );
    // } catch (e) {
    //   emit(ButtonFailureState(error: e.toString()));
    // }
  }
}
