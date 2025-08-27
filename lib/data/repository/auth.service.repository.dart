import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paisay_da_da/data/api/api_path.dart';
import 'package:paisay_da_da/data/api/api_service.dart';
import 'package:paisay_da_da/domain/models/failture.model.dart';
import 'package:paisay_da_da/domain/models/success.model.dart';
import 'package:paisay_da_da/domain/repository/auth.repository.dart';

class AuthServiceRepository implements AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "739952193125-bon95u8t08cfk4lr9ehfef6cbgnetm7s.apps.googleusercontent.com",
    serverClientId:
        "739952193125-7i4hasvn481icr4r2o8i2trbbb51kr4g.apps.googleusercontent.com",
    scopes: ['email', 'profile'],
  );

  @override
  Future<Either<SuccessModel, FailtureModel>> googleAuth(
    BuildContext context,
  ) async {
    try {
      print("Starting Google Sign-In process...");
      final account = await _googleSignIn.signIn();

      if (account == null) {
        return Right(FailtureModel(message: "Google Sign-In was cancelled."));
      }
      print("Google Sign-In successful: ${account.email}");

      final auth = await account.authentication;

      final idToken = auth.idToken;

      print("Starting API request with ID Token: $idToken");

      var response = await ApiService.request(
        context: context,
        path: ApiPaths.google,
        method: RequestMethod.post,
        data: {
          "id_token": idToken,
        },
      );

      if (response != null) {
        if (response['success'] == true) {
          return Left(SuccessModel.fromJson(response));
        }
        return Right(FailtureModel.fromJson(response));
      }
      return Right(FailtureModel(message: "No response from server"));
    } catch (error) {
      return Right(FailtureModel(message: "Google Sign-In failed: $error"));
    }
  }

  @override
  Future<Either<FailtureModel, SuccessModel>> signup(
    BuildContext context, {
    required firstName,
    required lastName,
    required email,
    required password,
  }) async {
    try {
      var response = await ApiService.request(
        context: context,
        method: RequestMethod.post,
        path: ApiPaths.signup,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
        },
      );
      if (response != null) {
        if (response['status'] == true) {
          return Right(SuccessModel.fromJson(response));
        }
        return Left(FailtureModel.fromJson(response));
      }
      return Left(FailtureModel(message: "No response from server"));
    } catch (error) {
      return Left(FailtureModel(message: "Sign-In failed: $error"));
    }
  }
}
