import 'package:flutter/material.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/domain/repository/auth.repository.dart';
import 'package:paisay_da_da/presentation/notifier/loader.notifier.dart';
import 'package:provider/provider.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository});

  Future<bool> googleAuth(BuildContext context) async {
    final loaderNotifier = Provider.of<LoaderNotifier>(context, listen: false);

    try {
      loaderNotifier.setLoading(true);
      var response = await authRepository.googleAuth(context);

      return response.fold(
        (left) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(left.message.toString())),
          );
          return true;
        },
        (right) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(right.message.toString())),
          );
          return false;
        },
      );
    } finally {
      loaderNotifier.setLoading(false);
    }
  }

  Future<bool> signup(
    BuildContext context, {
    required firstName,
    required lastName,
    required email,
    required password,
  }) async {
    final loaderNotifier = Provider.of<LoaderNotifier>(context, listen: false);

    try {
      // Optional delay for testing loader
      loaderNotifier.setLoading(true);

      await Future.delayed(Duration(seconds: 2));

      var response = await authRepository.signup(
        context,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      return response.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(failure.message.toString()),
            ),
          );
          return false;
        },
        (success) {
          HiveDatabase.storeValue("token", success.token);
          HiveDatabase.storeValue("islogin", true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(success.message.toString()),
            ),
          );
          return true;
        },
      );
    } finally {
      loaderNotifier.setLoading(false);
    }
  }
}
