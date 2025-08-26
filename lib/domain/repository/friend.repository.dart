import 'package:dartz/dartz.dart';
import 'package:paisay_da_da/domain/models/accepted.request.model.dart';
import 'package:paisay_da_da/domain/models/failture.model.dart';
import 'package:paisay_da_da/domain/models/pending.request.model.dart';
import 'package:paisay_da_da/domain/models/success.model.dart';

abstract class FriendRepository {
  Future<Either<FailtureModel, SuccessModel>> sendRequest({
    required recieverEmail,
  });
  Future<Either<FailtureModel, PendingModel>> pendingRequest();

  Future<Either<FailtureModel, SuccessModel>> accept({required requestId});

  Future<Either<FailtureModel, SuccessModel>> reject({required requestId});

  Future<Either<FailtureModel, AcceptedModel>> acceptedRequest();
}
