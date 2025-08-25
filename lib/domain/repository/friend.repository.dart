import 'package:dartz/dartz.dart';
import 'package:paisay_da_da/domain/models/failture.model.dart';
import 'package:paisay_da_da/domain/models/success.model.dart';

abstract class FriendRepository {
  Future<Either<SuccessModel, FailtureModel>> sendRequest({
    required recieverEmail,
  });

  Future<Either<SuccessModel, FailtureModel>> accept();

  Future<Either<SuccessModel, FailtureModel>> reject();

  Future<Either<SuccessModel, FailtureModel>> acceptedRequest();

  Future<Either<SuccessModel, FailtureModel>> pendingRequest();
}
