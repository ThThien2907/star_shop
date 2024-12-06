import 'package:flutter_bloc/flutter_bloc.dart';

class AddressItemSelectionCubit extends Cubit<int>{
  AddressItemSelectionCubit() : super(0);

  int itemSelected = 0;

  itemSelection(int index){
    itemSelected = index;
    emit(index);
  }
}