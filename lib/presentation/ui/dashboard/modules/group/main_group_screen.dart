import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'package:paisay_da_da/core/log.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/group/group_detail_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/group/create_group_screen.dart';
import 'package:paisay_da_da/presentation/widgets/add_group.widget.dart';
import 'package:provider/provider.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    GroupNotifier groupProvider = Provider.of<GroupNotifier>(context);
    var groups = groupProvider.groupModel.groups;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              // print(value);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CreategroupScreen();
                  },
                ),
              );
            },
            child: Text(
              "Create Group",
              style: GoogleFonts.aBeeZee(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            groups!.isEmpty
                ? AddGroupWidget()
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        final group = groups[index];
                        final groupId = group.sId;
                        final expenseDetail = group.expenseDetail;
                        final userEmails = group.members
                            ?.map((member) => member.email)
                            .toList()
                            .cast<String>();
                        final createdBy = group.createdBy?.email;

                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          onTap: () {
                            Log.d(
                              "Group Name: ${group.name.toString()}\n",
                              "Group ID: $groupId\nUsers in group: $userEmails\nCreated By: $createdBy:",
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GroupDetailScreen(
                                  groupName: group.name.toString(),
                                  groupMembers: userEmails,
                                  createdBy: createdBy,
                                  groupId: groupId,
                                  expenseDetail: expenseDetail,
                                ),
                              ),
                            );
                          },
                          title: Text(
                            group.name.toString(),
                          ),
                          leading: Image.asset(
                            Constants.stickman2,
                            height: 50,
                          ),
                          trailing: group.expenseDetail!.isEmpty
                              ? const Text("no expense")
                              : Text(
                                  "${group.expenseDetail!.length} expense",
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
