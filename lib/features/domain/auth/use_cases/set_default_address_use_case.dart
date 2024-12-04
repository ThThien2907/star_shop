import 'package:dartz/dartz.dart';
import 'package:star_shop/common/use_case/use_case.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';
import 'package:star_shop/service_locator.dart';

class SetDefaultAddressUseCase extends UseCase<Either, String>{
  @override
  Future<Either> call({String? params}) async {
    return await sl<AuthRepository>().setDefaultAddress(params!);
  }
}