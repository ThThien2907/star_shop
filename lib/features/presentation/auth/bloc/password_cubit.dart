import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/features/presentation/auth/bloc/password_state.dart';

class PasswordCubit extends Cubit<PasswordState>{
  PasswordCubit() : super(PasswordHideState());

  hidePassword(){
    emit(PasswordHideState());
  }

  showPassword(){
    emit(PasswordShowState());
  }
}