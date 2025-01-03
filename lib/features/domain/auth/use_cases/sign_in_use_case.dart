import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/auth/models/user_sign_in_req.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';
import 'package:star_shop/service_locator.dart';
import 'package:star_shop/common/use_case/use_case.dart';

class SignInUseCase extends UseCase<Either, UserSignInReq>{
  @override
  Future<Either> call({UserSignInReq? params}) async {
    return await sl<AuthRepository>().signIn(params!);
  }
}