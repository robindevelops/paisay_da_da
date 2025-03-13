import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/multi_provider.dart';
import 'package:paisay_da_da/presentation/ui/welcome/welcome_screen.dart';

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
        home: WelcomeScreen(),
      ),
    );
  }
}
