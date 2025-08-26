import 'package:dartz/dartz.dart';
import 'package:paisay_da_da/data/api/api_path.dart';
import 'package:paisay_da_da/data/api/api_service.dart';
import 'package:paisay_da_da/domain/models/accepted.request.model.dart';
import 'package:paisay_da_da/domain/models/failture.model.dart';
import 'package:paisay_da_da/domain/models/pending.request.model.dart';
import 'package:paisay_da_da/domain/models/success.model.dart';
import 'package:paisay_da_da/domain/repository/friend.repository.dart';

class FriendServiceRepository implements FriendRepository {
  @override
  Future<Either<FailtureModel, SuccessModel>> sendRequest({
    required recieverEmail,
  }) async {
    try {
      var response = await ApiService.request(
        method: RequestMethod.post,
        path: ApiPaths.send,
        data: {
          "recieverEmail": recieverEmail,
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

  @override
  Future<Either<FailtureModel, SuccessModel>> accept(
      {required requestId}) async {
    try {
      var response = await ApiService.request(
        method: RequestMethod.post,
        path: "${ApiPaths.accept}/$requestId",
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

  @override
  Future<Either<FailtureModel, SuccessModel>> reject(
      {required requestId}) async {
    try {
      var response = await ApiService.request(
        method: RequestMethod.post,
        path: "${ApiPaths.reject}/$requestId",
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

  @override
  Future<Either<FailtureModel, AcceptedModel>> acceptedRequest() async {
    try {
      var response = await ApiService.request(
        method: RequestMethod.get,
        path: ApiPaths.accepted,
      );
      if (response != null) {
        if (response['status'] == true) {
          return Right(AcceptedModel.fromJson(response));
        }
        return Left(FailtureModel.fromJson(response));
      }
      return Left(FailtureModel(message: "No response from server"));
    } catch (error) {
      return Left(FailtureModel(message: "Sign-In failed: $error"));
    }
  }

  @override
  Future<Either<FailtureModel, PendingModel>> pendingRequest() async {
    try {
      var response = await ApiService.request(
        method: RequestMethod.get,
        path: ApiPaths.pending,
      );
      if (response != null) {
        if (response['status'] == true) {
          return Right(PendingModel.fromJson(response));
        }
        return Left(FailtureModel.fromJson(response));
      }
      return Left(FailtureModel(message: "No response from server"));
    } catch (error) {
      return Left(FailtureModel(message: "Sign-In failed: $error"));
    }
  }
}
