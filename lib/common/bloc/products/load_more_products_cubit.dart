import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/products/load_more_products_state.dart';
import 'package:star_shop/common/use_case/use_case.dart';

class LoadMoreProductsCubit extends Cubit<LoadMoreProductsState> {
  final UseCase useCase;

  LoadMoreProductsCubit({required this.useCase}) : super(LoadMoreProductsInitial());

  loadMoreProducts(int limit) async {
    emit(LoadMoreProductsLoading());

    var response = await useCase.call(params: limit);

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
