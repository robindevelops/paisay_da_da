import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:paisay_da_da/domain/models/failture.model.dart';
import 'package:paisay_da_da/domain/models/success.model.dart';

abstract class AuthRepository {
  Future<Either<SuccessModel, FailtureModel>> googleAuth(
    BuildContext context,
  );

  Future<Either<FailtureModel, SuccessModel>> signup(
    BuildContext context, {
    required firstName,
    required lastName,
    required email,
    required password,
    required fcmToken,
  });
}
