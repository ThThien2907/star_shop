import 'package:star_shop/features/domain/order/entities/order_entity.dart';

class OrderDisplayState {}

class OrderDisplayLoading extends OrderDisplayState{}

class OrderDisplayLoadFailure extends OrderDisplayState{
  final String error;

  OrderDisplayLoadFailure({required this.error});
}

class OrderDisplayLoaded extends OrderDisplayState{
  final List<OrderEntity> listOrder;

  OrderDisplayLoaded({required this.listOrder});
}

class OrderDisplayInitialState extends OrderDisplayState{}