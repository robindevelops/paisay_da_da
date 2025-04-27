import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/widgets/no_friends_found.widget.dart';
import 'package:provider/provider.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({super.key});

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
    FriendNotifier friendNotifier = Provider.of<FriendNotifier>(context);
    final userEmail = HiveDatabase.getValue(HiveDatabase.userKey);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Friend Request"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          friendNotifier.friendRequests.isEmpty
              ? NoFriendRequestsFound()
              : Expanded(
                  child: ListView.builder(
                    itemCount: friendNotifier.friendRequests.length,
                    itemBuilder: (context, index) {
                      var request = friendNotifier.friendRequests[index];
                      var name = request.sender?.name;
                      var id = request.sId.toString();

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 5,
                        ),
                        onTap: () {
                          print(id);
                        },
                        leading: CircleAvatar(
                          child: Image.asset(
                            Constants.stickman1,
                          ),
                        ),
                        title: Text(name!),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await friendNotifier.acceptRequest(
                                  requestId: id,
                                  context: context,
                                );
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await friendNotifier.rejectRequest(
                                  requestId: id,
                                  context: context,
                                );
                              },
                              icon: Icon(
                                Icons.cancel_rounded,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
