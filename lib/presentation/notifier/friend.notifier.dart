import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/socket.io.dart';
import 'package:paisay_da_da/domain/models/accepted.request.model.dart';
import 'package:paisay_da_da/domain/models/pending.request.model.dart';
import 'package:paisay_da_da/domain/repository/friend.repository.dart';

class FriendNotifier extends ChangeNotifier {
  SocketService socketService = SocketService();
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
      recieverEmail: recieverEmail,
    );
    response.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(failure.message.toString()),
          ),
        );
      },
      (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(success.message.toString()),
          ),
        );
      },
    );
  }

  Future<void> pendingRequest(
    BuildContext context,
  ) async {
    var response = await friendRepository.pendingRequest();
    response.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(failure.message.toString()),
          ),
        );
      },
      (success) {
        _pendingModel = success; // replace instead of addAll
        notifyListeners(); // 👈 update UI
      },
    );
  }

  Future<void> accept(BuildContext context, {required requestId}) async {
    var response = await friendRepository.accept(requestId: requestId);
    response.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(failure.message.toString()),
          ),
        );
      },
      (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(success.message.toString()),
          ),
        );
        notifyListeners(); // 👈 update UI
      },
    );
  }

  Future<void> reject(BuildContext context, {required requestId}) async {
    var response = await friendRepository.reject(requestId: requestId);
    response.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(failure.message.toString()),
          ),
        );
      },
      (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(success.message.toString()),
          ),
        );
      },
    );
  }

  Future<void> acceptedRequest(BuildContext context) async {
    var response = await friendRepository.acceptedRequest();
    response.fold(
      (failure) {
        print(failure);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(failure.message.toString()),
          ),
        );
      },
      (success) {
        print(success);
        _acceptedModel = success;
        notifyListeners();
      },
    );
  }
}
