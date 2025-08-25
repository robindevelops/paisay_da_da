import 'package:dartz/dartz.dart';
import 'package:paisay_da_da/domain/models/failture.model.dart';
import 'package:paisay_da_da/domain/models/success.model.dart';
import 'package:paisay_da_da/domain/repository/friend.repository.dart';

class FriendServiceRepository implements FriendRepository {
  @override
  Future<Either<SuccessModel, FailtureModel>> sendRequest({
    required recieverEmail,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<SuccessModel, FailtureModel>> accept() {
    // TODO: implement accept
    throw UnimplementedError();
  }

  @override
  Future<Either<SuccessModel, FailtureModel>> reject() {
    // TODO: implement reject
    throw UnimplementedError();
  }

  @override
  Future<Either<SuccessModel, FailtureModel>> acceptedRequest() {
    // TODO: implement acceptedRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<SuccessModel, FailtureModel>> pendingRequest() {
    // TODO: implement pendingRequest
    throw UnimplementedError();
  }
}
