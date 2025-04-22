import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/locator.dart';
import 'package:paisay_da_da/data/local/hive.dart';

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveDatabase.init();
  ServiceLocator.setup();
}
