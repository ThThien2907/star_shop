import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_state.dart';
import 'package:star_shop/features/domain/auth/use_cases/get_user_use_case.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisplayState> {
  UserInfoDisplayCubit() : super(UserInfoDisplayLoading());

  Future<void> getUser() async {
    emit(UserInfoDisplayLoading());
    var isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isVerify) {
      var response = await GetUserUseCase().call(
        params: FirebaseAuth.instance.currentUser!.uid,
      );

      response.fold(
        (error) {
          emit(UserInfoDisplayLoadFailure(errorCode: error));
        },
        (data) {
          if (data == null) {
            emit(UserInfoEmpty());
          } else {
            emit(UserInfoDisplayLoaded(userEntity: data));
          }
        },
      );
    }
    else{
      emit(EmailNotVerified());
    }
  }
}
