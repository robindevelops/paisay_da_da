import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:paisay_da_da/data/api/api_exception.dart';
import 'package:paisay_da_da/data/api/api_path.dart';
import 'package:paisay_da_da/data/api/api_service.dart';
import 'package:paisay_da_da/domain/models/friendmodel/friend.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/failture.model.dart';
import 'package:paisay_da_da/domain/repository/friend.repository.dart';

class FriendServiceRepository implements FriendRepository {
  @override
  Future<Either<FriendModel, FailtureModel>> addFriend(
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
          return left(FriendModel.fromJson(response));
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
  Future<Either<FriendModel, FailtureModel>> getFriend(
      {required String email}) async {
    try {
      var response = await ApiService.request(
        "${ApiPaths.getAllFriend}/$email",
        method: RequestMethod.get,
      );
      if (response != null) {
        if (response['status'] == true) {
          return left(FriendModel.fromJson(response));
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
