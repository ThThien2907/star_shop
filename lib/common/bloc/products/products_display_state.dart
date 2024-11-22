import 'package:star_shop/features/domain/product/entities/product_entity.dart';

class ProductsDisplayState {}

class ProductsLoaded extends ProductsDisplayState{
  final List<ProductEntity> products;

  ProductsLoaded({required this.products});
}

class ProductsLoading extends ProductsDisplayState{}

class ProductsInitialState extends ProductsDisplayState{}

class ProductsLoadFailure extends ProductsDisplayState{
  final String error;

  ProductsLoadFailure({required this.error});
}