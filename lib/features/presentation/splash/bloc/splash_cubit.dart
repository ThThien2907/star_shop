import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/features/domain/auth/use_cases/is_logged_in_use_case.dart';
import 'package:star_shop/features/presentation/splash/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  appStarted() async {
    await Future.delayed(const Duration(seconds: 3));

    var isLoggedIn = await IsLoggedInUseCase().call();
    if (isLoggedIn) {
      emit(LoggedIn());
    } else {
      emit(NotLoggedIn());
    }
  }
}
