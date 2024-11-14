import 'package:get_it/get_it.dart';
import 'package:star_shop/features/data/auth/data_sources/auth_firebase_service.dart';
import 'package:star_shop/features/data/auth/repositories/auth_repository_impl.dart';
import 'package:star_shop/features/data/location/data_sources/api_location_service.dart';
import 'package:star_shop/features/data/location/repositories/location_repository_impl.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';
import 'package:star_shop/features/domain/location/repositories/location_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{

  //Service
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseService()
  );

  sl.registerSingleton<ApiLocationService>(
      ApiLocationService()
  );

  //Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<LocationRepository>(
      LocationRepositoryImpl()
  );

  //Use cases

}