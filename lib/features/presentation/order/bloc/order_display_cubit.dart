import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/features/domain/order/entities/order_entity.dart';
import 'package:star_shop/features/domain/order/use_cases/get_order_by_uid_use_case.dart';
import 'package:star_shop/features/presentation/order/bloc/order_display_state.dart';

class OrderDisplayCubit extends Cubit<OrderDisplayState> {
  OrderDisplayCubit() : super(OrderDisplayInitialState());

  List<OrderEntity> listPending = [];
  List<OrderEntity> listOngoing = [];
  List<OrderEntity> listComplete = [];
  List<OrderEntity> listCanceled = [];

  getOrder() async {
    emit(OrderDisplayLoading());
    var response = await GetOrderByUidUseCase().call();

    response.fold(
      (error) {
        emit(OrderDisplayLoadFailure(error: error));
      },
      (data) {
         listPending = data.where((e) => e.status == 'Pending').toList();
         listOngoing = data.where((e) => e.status == 'Ongoing').toList();
         listComplete = data.where((e) => e.status == 'Complete').toList();
         listCanceled = data.where((e) => e.status == 'Canceled').toList();
        emit(OrderDisplayLoaded(listOrder: data));
      },
    );
  }

  displayInitialState(){
    emit(OrderDisplayInitialState());
  }
}
