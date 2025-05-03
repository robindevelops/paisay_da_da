// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/domain/models/groupmodel/group.model.dart';
import 'package:paisay_da_da/presentation/animation/animation.dart';
import 'package:paisay_da_da/presentation/notifier/addMember.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/expense/add_expense.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/friends/add_members_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/group/group_setting_screen.dart';
import 'package:paisay_da_da/presentation/widgets/expense_tile.dart';
import 'package:paisay_da_da/presentation/widgets/no_expense_widget.dart';
import 'package:paisay_da_da/presentation/widgets/no_group_member_widget.dart';
import 'package:provider/provider.dart';

class GroupDetailScreen extends StatefulWidget {
  String? groupId;
  String? groupName;
  String? createdBy;
  List<String>? groupMembers;
  List<ExpenseDetail>? expenseDetail;

  GroupDetailScreen(
      {super.key,
      required this.groupName,
      required this.groupMembers,
      required this.createdBy,
      required this.groupId,
      required this.expenseDetail});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    void _navigateToAddExpenseScreen() {
      Navigator.of(context).push(
        AnimationUtil.circularRevealTransition(
          page: AddExpenseScreen(
            name: widget.groupName,
            groupMembers: widget.groupMembers,
            groupid: widget.groupId,
          ),
          centerAlignment: Alignment.bottomCenter,
          duration: const Duration(milliseconds: 600),
        ),
      );
    }

    GroupNotifier groupNotifier = Provider.of<GroupNotifier>(context);
    FriendNotifier friendNotifier = context.watch<FriendNotifier>();

    AddMemberNotifier addMemberNotifier = context.watch<AddMemberNotifier>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.group,
                color: Colors.black,
                size: 30,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  widget.groupName.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "No expense here yet",
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddMembersScreen(
                      groupId: widget.groupId.toString(),
                      groupMembers: widget.groupMembers,
                      isGroup: true,
                    );
                  },
                ),
              );
            },
            icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GroupSettingScreen(
                      groupMembers: widget.groupMembers,
                      createdBy: widget.createdBy,
                      groupId: widget.groupId,
                    );
                  },
                ),
              );
            },
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        backgroundColor: AppThemes.highlightGreen,
        color: Colors.black,
        onRefresh: () async {
          // final userEmail = HiveDatabase.getValue(HiveDatabase.userKey);

          // await groupNotifier.getGroups(
          //   email: userEmail,
          // );
        },
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: widget.groupMembers!.length == 1
                    ? NoGroupMemberWidget(
                        groupId: widget.groupId.toString(),
                        groupMembers: widget.groupMembers,
                      )
                    : widget.expenseDetail!.isEmpty
                        ? NoExpenseWidget(
                            message: 'No expenes in this group yet',
                          )
                        : ExpenseTile(expenseDetail: widget.expenseDetail),
              ),
            ),
            // addMemberNotifier.leftGroup.isEmpty
            //     ? SizedBox.shrink()
            //     : Text(
            //         "${addMemberNotifier.leftGroup} left the group",
            //         style: const TextStyle(
            //           color: Colors.black,
            //           fontSize: 15,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
          ],
        ),
      ),
      floatingActionButton: widget.groupMembers!.length == 1
          ? const SizedBox.shrink()
          : FloatingActionButton.extended(
              onPressed: () => _navigateToAddExpenseScreen(),
              backgroundColor: AppThemes.highlightGreen,
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text(
                "Split Money",
                style: TextStyle(color: Colors.black),
              ),
            ),
    );
  }
}
