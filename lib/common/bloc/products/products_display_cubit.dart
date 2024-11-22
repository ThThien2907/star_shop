import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/products/products_display_state.dart';
import 'package:star_shop/common/use_case/use_case.dart';

class ProductsDisplayCubit extends Cubit<ProductsDisplayState> {
  final UseCase useCase;

  ProductsDisplayCubit({required this.useCase}) : super(ProductsInitialState());

  getProducts({dynamic params}) async {
    emit(ProductsLoading());

    var response = await useCase.call(params: params);

    response.fold(
      (error) {
        emit(ProductsLoadFailure(error: error));
      },
      (data) {
        emit(ProductsLoaded(products: data));
      },
    );
  }
}
