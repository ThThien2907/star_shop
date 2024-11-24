import 'package:star_shop/features/domain/product/entities/product_entity.dart';

class FavoriteProductState{}

class FavoriteProductLoaded extends FavoriteProductState{
  final List<ProductEntity> products;

  FavoriteProductLoaded({required this.products});
}

class FavoriteProductLoading extends FavoriteProductState{}

class FavoriteProductLoadFailure extends FavoriteProductState{}

class FavoriteProductInitialState extends FavoriteProductState{
  final List<ProductEntity> products;

  FavoriteProductInitialState({required this.products});
}