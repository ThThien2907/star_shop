import 'package:star_shop/features/domain/product/entities/product_entity.dart';

class LoadMoreProductsState {}

class LoadMoreProductsLoaded extends LoadMoreProductsState{
  final List<ProductEntity> products;

  LoadMoreProductsLoaded({required this.products});
}

class LoadMoreProductsLoading extends LoadMoreProductsState{}
class LoadMoreProductsInitial extends LoadMoreProductsState{}

class LoadMoreProductsFailure extends LoadMoreProductsState{
  final String error;

  LoadMoreProductsFailure({required this.error});
}