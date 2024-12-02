import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';

class CartDisplayState {}

class CartDisplayLoading extends CartDisplayState {}

class CartDisplayLoadFailure extends CartDisplayState {
  final String error;

  CartDisplayLoadFailure({required this.error});
}

class CartDisplayLoaded extends CartDisplayState {
  final List<ProductOrderedEntity> products;

  CartDisplayLoaded({required this.products});
}

class CartDisplayInitialState extends CartDisplayState {
  final List<ProductOrderedEntity> products;

  CartDisplayInitialState({required this.products});
}
