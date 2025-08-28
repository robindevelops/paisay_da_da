import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:provider/provider.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({super.key});

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
    final friendNotifier = context.watch<FriendNotifier>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Friend Request"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: (friendNotifier.pendingModel.data == null ||
              friendNotifier.pendingModel.data!.isEmpty)
          ? Center(child: Text("No Friend Requests Found"))
          : ListView.builder(
              itemCount: friendNotifier.pendingModel.data!.length,
              itemBuilder: (context, index) {
                final request = friendNotifier.pendingModel.data![index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  title: Text(request.sender?.firstName ?? "Unknown"),
                  subtitle: Text(request.sender?.email ?? ""),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await friendNotifier.accept(context,
                              requestId: request.id);
                        },
                        icon: Icon(Icons.done, color: Colors.green),
                      ),
                      IconButton(
                        onPressed: () async {
                          await friendNotifier.reject(context,
                              requestId: request.id);
                        },
                        icon: Icon(Icons.cancel_rounded, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
