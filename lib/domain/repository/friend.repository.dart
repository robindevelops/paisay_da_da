import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:paisay_da_da/domain/models/accepted.request.model.dart';
import 'package:paisay_da_da/domain/models/failture.model.dart';
import 'package:paisay_da_da/domain/models/pending.request.model.dart';
import 'package:paisay_da_da/domain/models/success.model.dart';

abstract class FriendRepository {
  Future<Either<FailtureModel, SuccessModel>> sendRequest(
    BuildContext context, {
    required recieverEmail,
  });
  Future<Either<FailtureModel, PendingModel>> pendingRequest(
      BuildContext context);

  Future<Either<FailtureModel, SuccessModel>> accept(BuildContext context,
      {required requestId});

  Future<Either<FailtureModel, SuccessModel>> reject(BuildContext context,
      {required requestId});

  Future<Either<FailtureModel, AcceptedModel>> acceptedRequest(
    BuildContext context,
  );

  Future<Either<FailtureModel, SuccessModel>> sendReminder(BuildContext context,
      {required recieverEmail, required messsage});
}
