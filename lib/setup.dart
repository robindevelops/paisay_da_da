import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/locator.dart';
import 'package:paisay_da_da/data/local/hive.dart';

Future<void> setup() async {
  HiveDatabase.init();
  ServiceLocator.setup();
  WidgetsFlutterBinding.ensureInitialized();
}
