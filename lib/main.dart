import 'package:flutter/material.dart';
import 'package:paisay_da_da/app.dart';
import 'package:paisay_da_da/setup.dart';

Future<void> main() async {
  await setup();
  runApp(const MyApp());
}
