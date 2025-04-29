// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/themes.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/addMember.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

class AddMembersScreen extends StatefulWidget {
  String groupId;
  List<String>? groupMembers;

  AddMembersScreen(
      {super.key, required this.groupId, required this.groupMembers});

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FriendNotifier friendNotifier = Provider.of<FriendNotifier>(context);

    GroupNotifier groupNotifier = Provider.of<GroupNotifier>(context);
    var email = HiveDatabase.getValue(HiveDatabase.userKey);

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
          Consumer<AddMemberNotifier>(
            builder: (context, addMemberNotifier, child) {
              List<String> newMembers = addMemberNotifier.members
                  .where((email) =>
                      !(widget.groupMembers?.contains(email) ?? false))
                  .toList();

              bool hasNewMembers = newMembers.isNotEmpty;

              return TextButton(
                onPressed: hasNewMembers
                    ? () async {
                        await groupNotifier.addMember(
                          groupId: widget.groupId,
                          email: newMembers, // only send new members
                          context: context,
                        );

                        addMemberNotifier.clearMemeber();

                        await groupNotifier.getGroups(email: email);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    : null,
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: hasNewMembers ? Colors.black : Colors.grey,
                    fontSize: 17,
                  ),
                ),
              );
            },
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
              onChanged: (value) {
                // addMemberNotifier.filterMember(value, context);
              },
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
                      var friend = friendNotifier.friends[index];
                      var name = friend.name.toString();
                      var email = friend.email.toString();

                      return MemberTile(
                        name: name,
                        email: email,
                        groupemail: widget.groupMembers,
                      );
                    },
                  ),

            const SizedBox(height: 20),

            // Groups Section

            // const Text(
            //   "Groups",
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.black,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const SizedBox(height: 10),
            // groupNotifier.groupModel.groups!.isEmpty
            //     ? ListTile(
            //         title: Text("No group Found"),
            //       )
            //     : ListView.builder(
            //         shrinkWrap: true,
            //         physics: const NeverScrollableScrollPhysics(),
            //         itemCount: groupNotifier.groupModel.groups?.length,
            //         itemBuilder: (context, index) {
            //           var name = groupNotifier.groupModel.groups![index].name
            //               .toString();

            //           return MemberTile(
            //             name: name,
            //             email: '',
            //           );
            //         },
            //       ),
          ],
        ),
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  final String name;
  final String email;
  List<String>? groupemail;

  MemberTile(
      {super.key,
      required this.name,
      required this.email,
      required this.groupemail});

  @override
  Widget build(BuildContext context) {
    final addMemberNotifier = Provider.of<AddMemberNotifier>(context);
    final isSelected = addMemberNotifier.isSelected(email);
    bool isAlreadyInGroup = groupemail != null && groupemail!.contains(email);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      trailing: isAlreadyInGroup
          ? Text("Already member")
          : Checkbox(
              checkColor: Colors.black,
              activeColor: AppThemes.highlightGreen,
              value: isSelected,
              onChanged: (_) => addMemberNotifier.toggleMember(email),
            ),
      title: Row(
        children: [
          CircleAvatar(
            maxRadius: 20,
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.person, color: Colors.black, size: 25),
          ),
          const SizedBox(width: 10),
          Text(name),
        ],
      ),
    );
  }
}
