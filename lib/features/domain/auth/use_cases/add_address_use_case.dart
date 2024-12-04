import 'package:dartz/dartz.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/auth/entities/user_address_entity.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';
import 'package:star_shop/service_locator.dart';

class AddAddressUseCase extends UseCase<Either, UserAddressEntity>{
  @override
  Future<Either> call({UserAddressEntity? params}) async {
    return await sl<AuthRepository>().addAddress(params!);
  }
}