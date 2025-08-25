import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/presentation/widgets/no_friends_found.widget.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({super.key});

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
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
          // NoFriendRequestsFound(),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  onTap: () {},
                  leading: Image.asset(
                    Constants.account,
                    scale: 13,
                    fit: BoxFit.cover,
                  ),
                  title: Text("User Name"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {},
                        icon: Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {},
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
