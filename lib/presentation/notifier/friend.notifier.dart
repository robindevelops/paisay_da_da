import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/domain/models/friendmodel/friend.model.dart';
import 'package:paisay_da_da/domain/repository/friend.repository.dart';

class FriendNotifier extends ChangeNotifier {
  final FriendRepository friendsRepository;

  FriendNotifier({required this.friendsRepository});

  FriendsModel _friendsModel = FriendsModel(friends: []);
  FriendsModel _friendRequests = FriendsModel(friendRequests: []);

  List<Friends> get friends => _friendsModel.friends ?? [];
  List<FriendRequests> get friendRequests =>
      _friendRequests.friendRequests ?? [];

  Future<void> addFriend({
    required String senderEmail,
    required String receiverEmail,
    required BuildContext context,
  }) async {
    var response = await friendsRepository.addFriend(
      senderEmail: senderEmail,
      receiverEmail: receiverEmail,
    );

    response.fold(
      (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success.message.toString()),
            backgroundColor: Colors.green,
          ),
        );
      },
      (failure) {
        BaseHelper.showSnackBar(
          context,
          failure.message.toString(),
          Colors.red,
        );
        // if (failure.message == 'Sender or receiver not found.') {
        //   BaseHelper.showSnackBar(context, 'User not found 💨', Colors.red);
        // } else if (failure.message == 'Friend request already sent.') {
        //   BaseHelper.showSnackBar(
        //       context, 'Pehle wali pending hai bhai 😂', Colors.red);
        // } else if (failure.message ==
        //     'You cannot send a friend request to yourself.') {
        //   BaseHelper.showSnackBar(
        //       context, 'Nice try, lonely legend 🤡', Colors.red);
        // } else if (failure.message == 'You are already friends.') {
        //   BaseHelper.showSnackBar(
        //       context, 'You are already friends', Colors.red);
        // }
      },
    );
  }

  Future<void> getFriends({
    required String email,
    required BuildContext context,
  }) async {
    var response = await friendsRepository.getFriend(email: email);

    response.fold(
      (success) {
        _friendsModel = FriendsModel(friends: success.friends);
        _friendRequests = FriendsModel(friendRequests: success.friendRequests);

        notifyListeners();
      },
      (failure) {
        BaseHelper.showSnackBar(
          context,
          'Error: ${failure.message}',
          Colors.red,
        );
      },
    );
  }

  Future<void> acceptRequest({
    required String requestId,
    context,
  }) async {
    var response = await friendsRepository.acceptRequest(requestId: requestId);

    response.fold(
      (success) {
        BaseHelper.showSnackBar(
          context,
          success.message.toString(),
          Colors.green,
        );
      },
      (failure) {
        BaseHelper.showSnackBar(
          context,
          '${failure.message}',
          Colors.red,
        );
      },
    );
  }

  Future<void> rejectRequest({
    required String requestId,
    context,
  }) async {
    var response = await friendsRepository.rejectRequest(requestId: requestId);

    response.fold(
      (success) {
        BaseHelper.showSnackBar(
          context,
          success.message.toString(),
          Colors.green,
        );
      },
      (failure) {
        BaseHelper.showSnackBar(
          context,
          'Error: ${failure.message}',
          Colors.red,
        );
      },
    );
  }
}
