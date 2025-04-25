// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/group/main_group_screen.dart';
import 'package:provider/provider.dart';

class GroupSettingScreen extends StatefulWidget {
  List<String>? groupMembers;
  String? createdBy;
  String? groupId;
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
    var UserEmail = HiveDatabase.getValue(HiveDatabase.userKey);
    final isGroupCreator = UserEmail == widget.createdBy;
    GroupNotifier groupProvider = Provider.of<GroupNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Group Settings",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Group Members",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Container(
                  //   width: 20,
                  //   height: 20,
                  //   decoration: BoxDecoration(
                  //     color: Colors.black,
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       widget.groupMembers!.length.toString(),
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 12,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 12),
              widget.groupMembers!.isEmpty
                  ? ListTile(
                      onTap: () {},
                      title: const Text("No members found"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.groupMembers?.length ?? 0,
                      itemBuilder: (context, index) {
                        final memberEmail = widget.groupMembers![index];
                        return ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                          ),
                          title: Text(memberEmail),
                          trailing: memberEmail == widget.createdBy
                              ? Container(
                                  width: 53,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Admin",
                                      style: GoogleFonts.aBeeZee(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        );
                      },
                    ),
              const SizedBox(height: 30),
              isGroupCreator
                  ? ListTile(
                      onTap: () async {
                        await groupProvider.deleteGroup(
                          groupId: widget.groupId.toString(),
                          context: context,
                        );

                        groupProvider.getGroups(email: UserEmail);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      title: const Text(
                        "Delete Group",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      leading: const Icon(Icons.delete, color: Colors.red),
                    )
                  : SizedBox.shrink(),
              ListTile(
                onTap: () async {
                  await groupProvider.leaveGroup(
                    groupId: widget.groupId.toString(),
                    userEmail: UserEmail,
                    context: context,
                  );

                  groupProvider.getGroups(email: UserEmail);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                title: const Text(
                  "Exit Group",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
