import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';
import 'package:star_shop/service_locator.dart';

class IsLoggedInUseCase extends UseCase<bool, dynamic>{
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }

}