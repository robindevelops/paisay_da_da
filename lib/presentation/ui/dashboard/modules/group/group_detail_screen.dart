// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/presentation/animation/animation.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/add/add_expense.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/add/add_members_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/group/group_setting_screen.dart';
import 'package:paisay_da_da/presentation/widgets/expense_tile.dart';

class GroupDetailScreen extends StatefulWidget {
  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    void _navigateToAddExpenseScreen() {
      Navigator.of(context).push(
        AnimationUtil.circularRevealTransition(
          page: AddExpenseScreen(),
          centerAlignment: Alignment.bottomCenter,
          duration: const Duration(milliseconds: 600),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 105,
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
                  "Group Name",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 70,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppThemes.highlightGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "2 expenses",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Text(
                //   "No expense here yet",
                //   style: GoogleFonts.aBeeZee(
                //     color: Colors.white,
                //     fontSize: 12,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
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
                    return AddMembersScreen();
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
                    return GroupSettingScreen();
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
        onRefresh: () async {},
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
//  NoGroupMemberWidget(),

                  //     NoExpenseWidget(
                  //   message: 'No expemse',
                  // )
                  // child: ExpenseTile(),
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
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
