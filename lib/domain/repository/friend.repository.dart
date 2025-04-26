import 'package:dartz/dartz.dart';
import 'package:paisay_da_da/domain/models/friendmodel/friend.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/failture.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/success.model.dart';

abstract class FriendRepository {
  Future<Either<FriendsModel, FailtureModel>> addFriend({
    required String senderEmail,
    required String receiverEmail,
  });

  Future<Either<FriendsModel, FailtureModel>> getFriend({
    required String email,
  });

  Future<Either<SuccessModel, FailtureModel>> acceptRequest({
    required String requestId,
  });

  Future<Either<SuccessModel, FailtureModel>> rejectRequest({
    required String requestId,
  });
}
