import 'package:get_it/get_it.dart';
import 'package:star_shop/features/data/auth/data_sources/auth_firebase_service.dart';
import 'package:star_shop/features/data/auth/repositories/auth_repository_impl.dart';
import 'package:star_shop/features/data/category/data_sources/category_firebase_service.dart';
import 'package:star_shop/features/data/category/repositories/category_repository_impl.dart';
import 'package:star_shop/features/data/location/data_sources/api_location_service.dart';
import 'package:star_shop/features/data/location/repositories/location_repository_impl.dart';
import 'package:star_shop/features/data/product/data_sources/product_firebase_service.dart';
import 'package:star_shop/features/data/product/repositories/product_repository_impl.dart';
import 'package:star_shop/features/domain/auth/repositories/auth_repository.dart';
import 'package:star_shop/features/domain/category/repositories/category_repository.dart';
import 'package:star_shop/features/domain/location/repositories/location_repository.dart';
import 'package:star_shop/features/domain/product/repositories/product_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{

  //Service
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseService()
  );

  sl.registerSingleton<ApiLocationService>(
      ApiLocationService()
  );

  sl.registerSingleton<CategoryFirebaseService>(
      CategoryFirebaseService()
  );

  sl.registerSingleton<ProductFirebaseService>(
      ProductFirebaseService()
  );

  //Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<LocationRepository>(
      LocationRepositoryImpl()
  );

  sl.registerSingleton<CategoryRepository>(
      CategoryRepositoryImpl()
  );

  sl.registerSingleton<ProductRepository>(
      ProductRepositoryImpl()
  );

  //Use cases

}