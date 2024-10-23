import 'package:get_it/get_it.dart';
import 'package:star_shop/features/data/auth/data_sources/auth_firebase_service.dart';
import 'package:star_shop/features/data/auth/repositories/auth_repository_impl.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{

  //Service
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseService()
  );

  //Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  //Use cases

}