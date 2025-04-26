import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';
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
                        onTap: () {},
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

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FriendNotifier friendNotifier = Provider.of<FriendNotifier>(context);
    TextEditingController _emailController = TextEditingController();
    final senderEmail = HiveDatabase.getValue(HiveDatabase.userKey);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add Friend",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              if (_emailController.text.isEmpty) {
                BaseHelper.showSnackBar(context, "Email required", Colors.red);
                return;
              }

              return await friendNotifier.addFriend(
                senderEmail: senderEmail,
                receiverEmail: _emailController.text,
                context: context,
              );
            },
            child: const Text(
              "Send",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Enter email address',
              icon: Icons.email,
              controller: _emailController,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class NoFriendRequestsFound extends StatelessWidget {
  const NoFriendRequestsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Icon(
          //   Icons.person_off,
          //   size: 80,
          //   color: Colors.grey[400],
          // ),
          // const SizedBox(height: 20),
          const Text(
            "No Friend Requests Found",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "You're all caught up!",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class AddMembersScreen extends StatefulWidget {
  const AddMembersScreen({super.key});

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> friends = ["Furqan Abid", "Ali Khan"];
  final List<String> groups = ["Flutter Bros", "Design Squad"];

  @override
  Widget build(BuildContext context) {
    FriendNotifier friendNotifier = Provider.of<FriendNotifier>(context);
    GroupNotifier groupNotifier = Provider.of<GroupNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add Members",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              // Save logic
            },
            child: const Text(
              "Save",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "Search Members or Groups",
              icon: Icons.search,
              controller: _searchController,
            ),
            const SizedBox(height: 20),

            // Friends Section

            const Text(
              "Friends",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),

            friendNotifier.friends.isEmpty
                ? ListTile(
                    title: Text("No Member Found"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: friendNotifier.friends.length,
                    itemBuilder: (context, index) {
                      var name = friendNotifier.friends[index].name.toString();
                      return MemberTile(
                        name: name,
                      );
                    },
                  ),

            const SizedBox(height: 20),

            // Groups Section

            const Text(
              "Groups",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            groupNotifier.groupModel.groups!.isEmpty
                ? ListTile(
                    title: Text("No group Found"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: groupNotifier.groupModel.groups?.length,
                    itemBuilder: (context, index) {
                      var name = groupNotifier.groupModel.groups![index].name
                          .toString();
                      return MemberTile(
                        name: name,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  final String name;
  const MemberTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      trailing: Checkbox(
        activeColor: Colors.black,
        value: true,
        onChanged: (value) {},
      ),
      title: Row(
        children: [
          CircleAvatar(
            maxRadius: 20,
            backgroundColor: Colors.grey[200],
            child: const Icon(
              Icons.person,
              color: Colors.black,
              size: 25,
            ),
          ),
          const SizedBox(width: 10),
          Text(name),
        ],
      ),
    );
  }
}
