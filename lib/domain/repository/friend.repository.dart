import 'package:dartz/dartz.dart';
import 'package:paisay_da_da/domain/models/friendmodel/friend.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/failture.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/authentication.model.dart';

abstract class FriendRepository {
  Future<Either<FriendModel, FailtureModel>> addFriend({
    required String senderEmail,
    required String receiverEmail,
  });

  Future<Either<FriendModel, FailtureModel>> getFriend({
    required String email,
  });
}
