import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/products/load_more_products_state.dart';
import 'package:star_shop/features/domain/product/use_cases/get_products_use_case.dart';

class LoadMoreProductsCubit extends Cubit<LoadMoreProductsState> {
  LoadMoreProductsCubit() : super(LoadMoreProductsInitial());

  loadMoreProducts(int limit) async {
    emit(LoadMoreProductsLoading());

    var response = await GetProductsUseCase().call(params: limit);

    response.fold(
      (error) {
        emit(LoadMoreProductsFailure(error: error));
      },
      (data) {
        emit(LoadMoreProductsLoaded(products: data));
      },
    );
  }
}
