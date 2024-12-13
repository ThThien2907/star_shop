import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_state.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/domain/auth/use_cases/get_user_use_case.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisplayState> {
  UserInfoDisplayCubit() : super(UserInfoInitialState());

  late UserEntity userEntity;

  Future<void> getUser() async {
    emit(UserInfoLoading());
    var isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isVerify) {
      var response = await GetUserUseCase().call(
        params: FirebaseAuth.instance.currentUser!.uid,
      );

      response.fold(
        (error) {
          emit(UserInfoLoadFailure(errorCode: error));
        },
        (data) {
          if (data == null) {
            emit(UserInfoIsEmpty());
          }
          else if (data == 'UserAddressIsEmpty'){
            emit(UserAddressIsEmpty());
          }
          else {
            userEntity = data;
            // if (userEntity.role == 'AD') {
            //   emit(IsAdmin(userEntity: userEntity));
            // }else{
              emit(UserInfoLoaded(userEntity: userEntity));
            // }
          }
        },
      );
    } else {
      emit(EmailNotVerified());
    }
  }

  displayInitialState(){
    emit(UserInfoInitialState());
  }
}
