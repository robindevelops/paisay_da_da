import 'package:get_it/get_it.dart';
import 'package:paisay_da_da/data/repository/auth.service.repository.dart';
import 'package:paisay_da_da/domain/repository/auth.repository.dart';

class ServiceLocator {
  static final getIt = GetIt.instance;

  static setup() {
    getIt.registerLazySingleton<AuthRepository>(() => AuthServiceRepository());
  }

  static T get<T extends Object>() => getIt.get<T>();
}
