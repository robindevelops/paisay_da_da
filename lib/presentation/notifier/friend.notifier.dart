import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/constants/base_helper.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/domain/models/accepted.request.model.dart';
import 'package:paisay_da_da/domain/models/pending.request.model.dart';
import 'package:paisay_da_da/domain/repository/friend.repository.dart';

class FriendNotifier extends ChangeNotifier {
  FriendRepository friendRepository;

  FriendNotifier({required this.friendRepository});

  AcceptedModel _acceptedModel = AcceptedModel();

  AcceptedModel get acceptedModel => _acceptedModel;

  PendingModel _pendingModel = PendingModel();
  PendingModel get pendingModel => _pendingModel;

  Future<void> sendRequest(
    BuildContext context, {
    required recieverEmail,
  }) async {
    var response = await friendRepository.sendRequest(
      context,
      recieverEmail: recieverEmail,
    );
    response.fold(
      (failure) {
        BaseHelper.showSnackBar(
          context,
          failure.message.toString(),
          Colors.red,
        );
      },
      (success) {
        BaseHelper.showSnackBar(
          context,
          success.message.toString(),
          AppThemes.highlightGreen,
        );
      },
    );
  }

  Future<void> pendingRequest(
    BuildContext context,
  ) async {
    var response = await friendRepository.pendingRequest(context);
    response.fold(
      (failure) {
        BaseHelper.showSnackBar(
          context,
          failure.message.toString(),
          Colors.red,
        );
      },
      (success) {
        _pendingModel = success; // replace instead of addAll
        notifyListeners(); // 👈 update UI
      },
    );
  }

  Future<void> accept(BuildContext context, {required requestId}) async {
    var response = await friendRepository.accept(context, requestId: requestId);
    response.fold(
      (failure) {
        BaseHelper.showSnackBar(
          context,
          failure.message.toString(),
          Colors.red,
        );
      },
      (success) {
        BaseHelper.showSnackBar(
          context,
          success.message.toString(),
          AppThemes.highlightGreen,
        );
        notifyListeners(); // 👈 update UI
      },
    );
  }

  Future<void> reject(BuildContext context, {required requestId}) async {
    var response = await friendRepository.reject(context, requestId: requestId);
    print(response);
    response.fold(
      (failure) {
        BaseHelper.showSnackBar(
          context,
          failure.message.toString(),
          Colors.red,
        );
      },
      (success) {
        BaseHelper.showSnackBar(
          context,
          success.message.toString(),
          AppThemes.highlightGreen,
        );
      },
    );
  }

  Future<void> acceptedRequest(BuildContext context) async {
    var response = await friendRepository.acceptedRequest(context);
    response.fold(
      (failure) {
        BaseHelper.showSnackBar(
          context,
          failure.message.toString(),
          Colors.red,
        );
      },
      (success) {
        _acceptedModel = success;
        notifyListeners();
      },
    );
  }

  Future<void> sendReminder(BuildContext context,
      {required recieverEmail, required messsage}) async {
    var response = await friendRepository.sendReminder(
      context,
      recieverEmail: recieverEmail,
      messsage: messsage,
    );
    response.fold(
      (failure) {
        BaseHelper.showSnackBar(
          context,
          failure.message.toString(),
          Colors.red,
        );
      },
      (success) {
        BaseHelper.showSnackBar(
          context,
          success.message.toString(),
          AppThemes.highlightGreen,
        );
        notifyListeners();
      },
    );
  }
}
