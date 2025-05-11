// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/base_helper.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/addMember.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/widgets/admin_widget.dart';
import 'package:provider/provider.dart';

class GroupSettingScreen extends StatefulWidget {
  final List<String>? groupMembers;
  final String? createdBy;
  final String? groupId;

  GroupSettingScreen({
    super.key,
    required this.groupMembers,
    required this.createdBy,
    required this.groupId,
  });

  @override
  State<GroupSettingScreen> createState() => _GroupSettingScreenState();
}

class _GroupSettingScreenState extends State<GroupSettingScreen> {
  @override
  Widget build(BuildContext context) {
    final userEmail = HiveDatabase.getValue(HiveDatabase.userKey);
    final isGroupCreator = userEmail == widget.createdBy;
    final groupProvider = Provider.of<GroupNotifier>(context);
    final friendNotifier = Provider.of<FriendNotifier>(context);

    var friends = friendNotifier.friends.map(
      (friend) {
        return friend.email;
      },
    ).toList();

    final addMemberNotifier = Provider.of<AddMemberNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Group Settings",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              print(friends);
            },
            child: Text(
              "Edit",
              style: GoogleFonts.aBeeZee(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Group Members",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {
                // Add group member functionality here
              },
              leading: const Icon(Icons.person_add_alt),
              title: const Text("Add Group Members"),
            ),
            const SizedBox(height: 10),
            if (widget.groupMembers == null || widget.groupMembers!.isEmpty)
              const ListTile(
                title: Text("No members found"),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.groupMembers?.length,
                itemBuilder: (context, index) {
                  final memberEmail = widget.groupMembers![index];

                  return ListTile(
                    leading: const Icon(Icons.person_2_outlined),
                    title: Text(
                      getUsernameFromEmail(memberEmail),
                      style: GoogleFonts.aBeeZee(),
                    ),
                    subtitle: Text(memberEmail),
                    trailing: memberEmail == widget.createdBy
                        ? const AdminWidget()
                        : isGroupCreator
                            ? IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz),
                              )
                            : friends.contains(memberEmail) ||
                                    memberEmail == userEmail
                                ? null
                                : TextButton(
                                    onPressed: () async {
                                      print(memberEmail);
                                      await friendNotifier.addFriend(
                                        senderEmail: userEmail,
                                        receiverEmail: memberEmail,
                                        context: context,
                                      );
                                    },
                                    child: const Text(
                                      "Add friend",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                  );
                },
              ),
            const SizedBox(height: 20),
            if (isGroupCreator)
              ListTile(
                onTap: () {
                  BaseHelper.showDBottomSheet(
                    context,
                    message: "Delete Group",
                    title: "Are you sure you want to delete this group?",
                    buttoncolor: Colors.red,
                    onPressed: () async {
                      Navigator.pop(context);

                      await groupProvider.deleteGroup(
                        groupId: widget.groupId.toString(),
                        context: context,
                      );

                      addMemberNotifier.clearMemeber();
                      await groupProvider.getGroups(email: userEmail);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                  );
                },
                title: const Text(
                  "Delete Group",
                  style: TextStyle(color: Colors.red),
                ),
                leading: const Icon(Icons.delete, color: Colors.red),
              ),
            ListTile(
              onTap: () async {
                await groupProvider.leaveGroup(
                  groupId: widget.groupId.toString(),
                  userEmail: userEmail,
                  context: context,
                );

                addMemberNotifier.addleftGroup(getUsernameFromEmail(userEmail));
                await groupProvider.getGroups(email: userEmail);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              title: const Text(
                "Exit Group",
                style: TextStyle(color: Colors.red),
              ),
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

String getUsernameFromEmail(String email) {
  return email.split('@')[0].toUpperCase();
}
