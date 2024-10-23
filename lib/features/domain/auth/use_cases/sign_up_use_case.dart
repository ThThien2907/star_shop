import 'package:dartz/dartz.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/utils/use_case/use_case.dart';

class SignUpUseCase extends UseCase<Either, UserEntity>{
  @override
  Future<Either> call({UserEntity? params}) {
    // TODO: implement call
    throw UnimplementedError();
  }

}