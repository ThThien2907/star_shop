import 'package:flutter_bloc/flutter_bloc.dart';

class ProductImageSelectionCubit extends Cubit<int>{
  ProductImageSelectionCubit() : super(0);

  imageSelection(int index){
    emit(index);
  }
}