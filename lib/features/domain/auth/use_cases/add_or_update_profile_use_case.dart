import 'package:dartz/dartz.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';
import 'package:star_shop/service_locator.dart';

class AddOrUpdateProfileUseCase extends UseCase<Either, UserEntity>{
  @override
  Future<Either> call({UserEntity? params}) async {
    return await sl<AuthRepository>().addOrUpdateProfile(params!);
  }
}