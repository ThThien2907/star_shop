import 'package:dartz/dartz.dart';
import 'package:star_shop/features/data/auth/models/user_sign_up_req.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';
import 'package:star_shop/service_locator.dart';
import 'package:star_shop/utils/use_case/use_case.dart';

class SignUpUseCase extends UseCase<Either, UserSignUpReq>{
  @override
  Future<Either> call({UserSignUpReq? params}) async{
    return await sl<AuthRepository>().signUp(params!);
  }

}