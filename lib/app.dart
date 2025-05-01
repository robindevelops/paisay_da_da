import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/app_builder.dart';
import 'package:paisay_da_da/core/provider/multi_provider.dart';
import 'package:paisay_da_da/presentation/ui/splash/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return AppBuilder(widget: child!);
        },
        home: SplashScreen(),
      ),
    );
  }
}
