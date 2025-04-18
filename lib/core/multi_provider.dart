import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/locator.dart';
import 'package:paisay_da_da/domain/repository/auth.repository.dart';
import 'package:paisay_da_da/presentation/notifier/auth.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/connection.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/load.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/rootVm.notifier.dart';
import 'package:provider/provider.dart';

class MultiProviders extends StatelessWidget {
  const MultiProviders({required this.child, Key? key}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return Rootvm();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return AuthenticationNotifier(
              authRepository: ServiceLocator.getIt(),
            );
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return FriendNotifier(
              friendsRepository: ServiceLocator.getIt(),
            );
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ConnectionNotifier();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return GroupNotifier(groupRepository: ServiceLocator.getIt());
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return LoaderNotifier();
          },
        ),
      ],
      child: child,
    );
  }
}
