import 'package:dartz/dartz.dart';
import 'package:paisay_da_da/data/api/api_path.dart';
import 'package:paisay_da_da/data/api/api_service.dart';
import 'package:paisay_da_da/domain/models/generalmodel/authentication.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/failture.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/success.model.dart';
import 'package:paisay_da_da/domain/models/groupmodel/group.model.dart';
import 'package:paisay_da_da/domain/repository/group.repository.dart';

class GroupServiceRepository implements GroupRepository {
  @override
  Future<Either<GroupModel, FailtureModel>> createGroup(
      {required String createdBy,
      required String groupName,
      required List<String> members}) async {
    try {
      var response = await ApiService.request(
        ApiPaths.createGroup,
        method: RequestMethod.post,
        data: {
          "createdBy": createdBy,
          "name": groupName,
          "members": members,
        },
      );

      if (response != null) {
        if (response['success'] == true) {
          return left(GroupModel.fromJson(response));
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
  Future<Either<GroupModel, FailtureModel>> getGroups(
      {required String useremail}) async {
    try {
      var response = await ApiService.request(
        ApiPaths.getGroup,
        method: RequestMethod.get,
        data: {
          "email": useremail,
        },
      );
      if (response != null) {
        if (response['success'] == true) {
          return left(GroupModel.fromJson(response));
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
  Future<Either<SuccessModel, FailtureModel>> deleteGroup(
      {required String groupId}) async {
    try {
      var response = await ApiService.request(
        ApiPaths.deleteGroup,
        method: RequestMethod.delete,
        data: {
          "groupId": groupId,
        },
      );
      if (response != null) {
        if (response['success'] == true) {
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
  Future<Either<SuccessModel, FailtureModel>> leaveGroup(
      {required String groupId, required String userEmail}) async {
    try {
      var response = await ApiService.request(
        ApiPaths.leaveGroup,
        method: RequestMethod.post,
        data: {
          "groupId": groupId,
          "userEmail": userEmail,
        },
      );
      if (response != null) {
        if (response['success'] == true) {
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
