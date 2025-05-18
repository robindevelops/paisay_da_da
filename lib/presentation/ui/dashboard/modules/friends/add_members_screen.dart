// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/addMember.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

class AddMembersScreen extends StatefulWidget {
  String? groupId;
  List<String>? groupMembers;
  bool isGroup = false;

  AddMembersScreen({
    super.key,
    this.groupId,
    this.groupMembers,
    this.isGroup = false,
  });

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
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Consumer<AddMemberNotifier>(
            builder: (context, addMemberNotifier, child) {
              List<String> newMembers = addMemberNotifier.members
                  .where((email) =>
                      !(widget.groupMembers?.contains(email) ?? false))
                  .toList();

              bool hasNewMembers = newMembers.isNotEmpty;

              return widget.isGroup
                  ? TextButton(
                      onPressed: hasNewMembers
                          ? () async {
                              await groupNotifier.addMember(
                                groupId: widget.groupId.toString(),
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
                          color: hasNewMembers ? Colors.white : Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: hasNewMembers
                          ? () async {
                              Navigator.pop(context);
                            }
                          : null,
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: hasNewMembers ? Colors.white : Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            CustomTextField(
              hintText: "Search members",
              icon: Icons.search,
              controller: _searchController,
              onChanged: (value) {
                friendNotifier.filterFriends(value);
              },
            ),
            const SizedBox(height: 20),

            // Friends Section

            Text(
              "Friends",
              style: GoogleFonts.aBeeZee(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            friendNotifier.filteredFriends.isEmpty
                ? ListTile(
                    title: Text("No Member Found"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: friendNotifier.filteredFriends.length,
                    itemBuilder: (context, index) {
                      var friend = friendNotifier.filteredFriends[index];
                      var name = friend.name;
                      var email = friend.email;

                      return MemberTile(
                        name: name.toString(),
                        email: email.toString(),
                        groupemail: widget.groupMembers,
                      );
                    },
                  ),

            const SizedBox(height: 20),

            // Groups Section (commented out for now)
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
            //
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

  MemberTile({
    super.key,
    required this.name,
    required this.email,
    required this.groupemail,
  });

  @override
  Widget build(BuildContext context) {
    final addMemberNotifier = Provider.of<AddMemberNotifier>(context);
    final isSelected = addMemberNotifier.isSelected(email);
    bool isAlreadyInGroup = groupemail != null && groupemail!.contains(email);
    return ListTile(
      leading: const Icon(Icons.person_3_outlined),
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      trailing: isAlreadyInGroup
          ? Text("Already member")
          : Checkbox(
              checkColor: Colors.black,
              activeColor: AppThemes.highlightGreen,
              value: isSelected,
              onChanged: (_) => addMemberNotifier.toggleMember(email),
            ),
      title: Text(name.capitalizeFirst()),
    );
  }
}

extension StringCasingExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
