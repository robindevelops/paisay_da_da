import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/domain/repository/friend.repository.dart';

class FriendNotifier extends ChangeNotifier {
  FriendRepository friendsRepository;

  FriendNotifier({required this.friendsRepository});

  List _friendList = [];

  List get friendList => _friendList;

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
            content: Text("Friend request sent ✅"),
            backgroundColor: Colors.green,
          ),
        );
      },
      (failure) {
        if (failure.message == 'Sender or receiver not found.') {
          BaseHelper.showSnackBar(context, 'User not found 💨', Colors.red);
        } else if (failure.message == 'Friend request already sent.') {
          BaseHelper.showSnackBar(
              context, 'Pehle wali pending hai bhai 😂', Colors.red);
        } else if (failure.message ==
            'You cannot send a friend request to yourself.') {
          BaseHelper.showSnackBar(
              context, 'Nice try, lonely legend 🤡', Colors.red);
        } else if (failure.message == 'You are already friends.') {
          BaseHelper.showSnackBar(
              context, 'You are already friends', Colors.red);
        }
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
        _friendList = success.friends!;
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
