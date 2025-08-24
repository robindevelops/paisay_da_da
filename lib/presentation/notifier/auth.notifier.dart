import 'package:flutter/material.dart';
import 'package:paisay_da_da/domain/repository/auth.repository.dart';
import 'package:paisay_da_da/presentation/notifier/loader.notifier.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthRepository authRepository;

  LoaderNotifier loaderNotifier = LoaderNotifier();

  AuthNotifier({required this.authRepository});

  Future<bool> googleAuth(BuildContext context) async {
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
  }
}
