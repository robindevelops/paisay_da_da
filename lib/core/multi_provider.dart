import 'package:flutter/material.dart';
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
      ],
      child: child,
    );
  }
}
