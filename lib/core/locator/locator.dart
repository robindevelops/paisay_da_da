import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final getIt = GetIt.instance;

  static setup() {}

  static T get<T extends Object>() => getIt.get<T>();
}
