import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/core/themes/log.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
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
        scrolledUnderElevation: 0,
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
      body: RefreshIndicator(
        backgroundColor: AppThemes.highlightGreen,
        color: Colors.black,
        onRefresh: () async {
          Future.delayed(
            const Duration(seconds: 1),
            () {},
          );
        },
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                groups!.isEmpty
                    ? AddGroupWidget()
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
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
                                scale: 13,
                                fit: BoxFit.cover,
                                Constants.account,
                              ),
                              trailing: group.expenseDetail!.isEmpty
                                  ? const Text("no expense")
                                  : Container(
                                      width: 70,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: AppThemes.highlightGreen,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${group.expenseDetail!.length} expense",
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
