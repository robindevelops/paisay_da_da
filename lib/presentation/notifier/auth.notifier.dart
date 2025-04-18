import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/domain/models/generalmodel/authentication.model.dart';
import 'package:paisay_da_da/domain/repository/auth.repository.dart';

class AuthenticationNotifier extends ChangeNotifier {
  AuthRepository authRepository;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthenticationNotifier({required this.authRepository});

  AuthenticationModel _authenticationModel = AuthenticationModel();

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2)); // Awaiting the delay

    final response = await authRepository.signup(
      name: name,
      email: email,
      password: password,
    );

    var result = response.fold(
      (success) {
        _authenticationModel = success;

        HiveDatabase.storeValue(
            HiveDatabase.tokenKey, _authenticationModel.token);
        HiveDatabase.storeValue(
            HiveDatabase.userKey, _authenticationModel.user?.email);
        HiveDatabase.storelogin(true);

        BaseHelper.showSnackBar(
          context,
          'Signup Successfull',
          Colors.green,
        );
        return true;
      },
      (failure) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (failure.message == 'Email-exists') {
          BaseHelper.showSnackBar(
            context,
            'Email already exists',
            Colors.red,
          );
        }
        return false;
      },
    );
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2)); // Awaiting the delay

    final response = await authRepository.signin(
      email: email,
      password: password,
    );

    final result = response.fold(
      (success) {
        _authenticationModel = success;

        HiveDatabase.storeValue(
            HiveDatabase.tokenKey, _authenticationModel.token);
        HiveDatabase.storeValue(
            HiveDatabase.userKey, _authenticationModel.user?.email);
        HiveDatabase.storelogin(true);
        // HiveDatabase.storeUser(_authenticationModel.user!.email);

        BaseHelper.showSnackBar(
          context,
          'Login successful',
          Colors.green,
        );
        return true;
      },
      (failure) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (failure.message == 'Email-not-found') {
          BaseHelper.showSnackBar(
            context,
            'Email not found',
            Colors.red,
          );
        } else if (failure.message == 'Password-incorrect') {
          BaseHelper.showSnackBar(
            context,
            'Password incorrect',
            Colors.red,
          );
        }
        return false;
      },
    );

    _isLoading = false;
    notifyListeners();
    return result;
  }
}
