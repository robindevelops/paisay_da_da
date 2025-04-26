import 'package:dartz/dartz.dart';
import 'package:paisay_da_da/domain/models/generalmodel/authentication.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/failture.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/success.model.dart';
import 'package:paisay_da_da/domain/models/groupmodel/group.model.dart';

abstract class GroupRepository {
  Future<Either<GroupModel, FailtureModel>> createGroup({
    required String createdBy,
    required String groupName,
    required List<String> members,
  });

  Future<Either<GroupModel, FailtureModel>> getGroups({
    required String useremail,
    String? groupId,
  });

  Future<Either<SuccessModel, FailtureModel>> deleteGroup({
    required String groupId,
  });

  Future<Either<SuccessModel, FailtureModel>> leaveGroup({
    required String groupId,
    required String userEmail,
  });

  Future<Either<SuccessModel, FailtureModel>> addMember({
    required String groupId,
    required List<String> members,
  });

  // Future<Either<AuthenticationModel, FailtureModel>> getGroup({
  //   required String groupId,
  // });

  // Future<Either<AuthenticationModel, FailtureModel>> updateGroup({
  //   required String groupId,
  //   required String groupName,
  //   required String groupDescription,
  // });
}
