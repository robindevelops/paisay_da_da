import 'package:get_it/get_it.dart';
import 'package:paisay_da_da/data/repository/auth.service.repository.dart';
import 'package:paisay_da_da/data/repository/friend.service.repository.dart';
import 'package:paisay_da_da/data/repository/group.service.repository.dart';
import 'package:paisay_da_da/domain/repository/auth.repository.dart';
import 'package:paisay_da_da/domain/repository/friend.repository.dart';
import 'package:paisay_da_da/domain/repository/group.repository.dart';

class ServiceLocator {
  static final getIt = GetIt.instance;

  static setup() {
    getIt.registerSingleton<AuthRepository>(AuthServriceRepository());
    // getIt.registerSingleton<FriendRepository>(FriendServiceRepository());
    getIt.registerSingleton<GroupRepository>(GroupServiceRepository());
  }

  static T get<T extends Object>() => getIt.get<T>();
}
