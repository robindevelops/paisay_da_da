import 'package:dartz/dartz.dart';
import 'package:paisay_da_da/domain/models/generalmodel/failture.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/authentication.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/success.model.dart';

abstract class AuthRepository {
  Future<Either<AuthenticationModel, FailtureModel>> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<AuthenticationModel, FailtureModel>> signin({
    required String email,
    required String password,
  });

  Future<Either<SuccessModel, FailtureModel>> deleteAccount({
    required String email,
  });
}
