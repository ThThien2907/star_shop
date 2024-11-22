import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/categories/categories_display_state.dart';
import 'package:star_shop/features/domain/category/use_cases/get_categories_use_case.dart';

class CategoriesDisplayCubit extends Cubit<CategoriesDisplayState> {
  CategoriesDisplayCubit() : super(CategoriesInitialState());

  getCategories() async {
    emit(CategoriesLoading());
    var response = await GetCategoriesUseCase().call();

    response.fold(
      (error) {
        emit(CategoriesLoadFailure(errorCode: error));
      },
      (data) {
        emit(CategoriesLoaded(categories: data));
      },
    );
  }
}
