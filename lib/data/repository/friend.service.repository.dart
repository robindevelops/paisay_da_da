import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:paisay_da_da/data/api/api_exception.dart';
import 'package:paisay_da_da/data/api/api_path.dart';
import 'package:paisay_da_da/data/api/api_service.dart';
import 'package:paisay_da_da/domain/models/friendmodel/friend.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/failture.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/success.model.dart';
import 'package:paisay_da_da/domain/repository/friend.repository.dart';

class FriendServiceRepository implements FriendRepository {
  @override
  Future<Either<FriendsModel, FailtureModel>> addFriend(
      {required String senderEmail, required String receiverEmail}) async {
    try {
      var response = await ApiService.request(ApiPaths.addFriend,
          method: RequestMethod.post,
          data: {
            "senderEmail": senderEmail,
            "receiverEmail": receiverEmail,
          });

      if (response != null) {
        if (response['status'] == true) {
          return left(FriendsModel.fromJson(response));
        } else {
          return right(FailtureModel.fromJson(response, String: null));
        }
      } else {
        return right(FailtureModel(message: 'An error occurred'));
      }
    } on DioException catch (e) {
      return right(FailtureModel(
          message: CustomDioException.fromDioError(e).toString()));
    } catch (e) {
      return right(FailtureModel(message: "Unexpected error: $e"));
    }
  }

  @override
  Future<Either<FriendsModel, FailtureModel>> getFriend(
      {required String email}) async {
    try {
      var response = await ApiService.request(
        ApiPaths.getFriend,
        method: RequestMethod.get,
        data: {
          "email": email,
        },
      );
      if (response != null) {
        if (response['status'] == true) {
          return left(FriendsModel.fromJson(response));
        } else {
          return right(FailtureModel.fromJson(response, String: null));
        }
      } else {
        return right(FailtureModel(message: 'An error occurred'));
      }
    } catch (e, stackTrace) {
      print("Error: $stackTrace");
      print("Error: $e");

      return right(FailtureModel(message: "Unexpected error: $e "));
    }
  }

  @override
  Future<Either<SuccessModel, FailtureModel>> acceptRequest(
      {required String requestId}) async {
    try {
      var response = await ApiService.request(
        ApiPaths.accept,
        method: RequestMethod.post,
        data: {
          "requestId": requestId,
        },
      );
      if (response != null) {
        if (response['status'] == true) {
          return left(SuccessModel.fromJson(response));
        } else {
          return right(FailtureModel.fromJson(response, String: null));
        }
      } else {
        return right(FailtureModel(message: 'An error occurred'));
      }
    } catch (e) {
      return right(FailtureModel(message: "Unexpected error: $e"));
    }
  }

  @override
  Future<Either<SuccessModel, FailtureModel>> rejectRequest(
      {required String requestId}) async {
    try {
      var response = await ApiService.request(
        ApiPaths.reject,
        method: RequestMethod.post,
        data: {
          "requestId": requestId,
        },
      );
      if (response != null) {
        if (response['status'] == true) {
          return left(SuccessModel.fromJson(response));
        } else {
          return right(FailtureModel.fromJson(response, String: null));
        }
      } else {
        return right(FailtureModel(message: 'An error occurred'));
      }
    } catch (e) {
      return right(FailtureModel(message: "Unexpected error: $e"));
    }
  }
}
