import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/favorite/favorite_product_state.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/domain/product/use_cases/add_or_remove_favorite_product_use_case.dart';
import 'package:star_shop/features/domain/product/use_cases/get_favorite_products_use_case.dart';

class FavoriteProductCubit extends Cubit<FavoriteProductState> {
  FavoriteProductCubit() : super(FavoriteProductInitialState(products: []));

  List<ProductEntity> products = [];

  getFavorite() async {
    emit(FavoriteProductLoading());
    var res = await GetFavoriteProductsUseCase().call();
    res.fold(
      (error) {
        emit(FavoriteProductLoadFailure());
      },
      (data) {
        products = data;
        emit(FavoriteProductLoaded(products: products));
      },
    );
  }

  toggleFavorite(ProductEntity productEntity) async {
    var response =
        await AddOrRemoveFavoriteProductUseCase().call(params: productEntity);
    response.fold(
      (error) {
      },
      (data) {
        if (data == true) {
          products.add(productEntity);
        } else {
          products.removeWhere((e) => e.productID == productEntity.productID);
        }
        emit(FavoriteProductLoaded(products: products));
      },
    );
  }

  displayInitialState(){
    emit(FavoriteProductInitialState(products: []));
  }
}
