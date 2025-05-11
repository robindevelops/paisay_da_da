import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/constants/base_helper.dart';
import 'package:paisay_da_da/domain/models/friendmodel/friend.model.dart';
import 'package:paisay_da_da/domain/repository/friend.repository.dart';

class FriendNotifier extends ChangeNotifier {
  final FriendRepository friendsRepository;

  FriendNotifier({required this.friendsRepository});

  FriendsModel _friendsModel = FriendsModel(friends: []);
  FriendsModel _friendRequests = FriendsModel(friendRequests: []);
  List<Friends> _filteredFriends = [];
  List<Friends> get filteredFriends => _filteredFriends;

  List<Friends> get friends => _friendsModel.friends ?? [];
  List<FriendRequests> get friendRequests =>
      _friendRequests.friendRequests ?? [];

  Future<void> filterFriends(String query) async {
    if (query.isEmpty) {
      _filteredFriends = List.from(_friendsModel.friends ?? []);
    } else {
      _filteredFriends = _friendsModel.friends!
          .where((friend) =>
              friend.name?.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ??
              false)
          .toList();
    }
    notifyListeners();
  }

  Future<bool> addFriend({
    required String senderEmail,
    required String receiverEmail,
    required BuildContext context,
  }) async {
    var response = await friendsRepository.addFriend(
      senderEmail: senderEmail,
      receiverEmail: receiverEmail,
    );

    var result = response.fold(
      (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success.message.toString()),
            backgroundColor: Colors.green,
          ),
        );
        return true;
      },
      (failure) {
        print(failure.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message.toString()),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      },
    );

    return result;
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
        _filteredFriends = List.from(_friendsModel.friends ?? []);

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
    required BuildContext context,
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
    required BuildContext context,
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
