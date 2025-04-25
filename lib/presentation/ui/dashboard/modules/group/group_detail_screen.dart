// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/domain/models/groupmodel/group.model.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/detail/total_bill.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/friends/friends_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/group/group_setting_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';

class GroupDetailScreen extends StatefulWidget {
  String? groupId;
  String? groupName;
  String? createdBy;
  List<String>? groupMembers;
  GroupDetailScreen({
    super.key,
    required this.groupName,
    required this.groupMembers,
    required this.createdBy,
    required this.groupId,
  });

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  @override
  Widget build(BuildContext context) {
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
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  widget.groupName.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "khata clear ha",
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: 15,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.groupMembers!.length == 1
                  ? NoGroupWidget()
                  : Text("No Expenses Yet in this group"),

              // Text("No expense here yet"),
              // Text("Tap the button to split money"),

              // Text(
              //   "Expenses",
              //   style: GoogleFonts.aBeeZee(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(height: 20),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: 4,
              //     itemBuilder: (context, index) {
              //       return Slidable(
              //         key: ValueKey(index),
              //         startActionPane: ActionPane(
              //           motion: const DrawerMotion(),
              //           children: [
              //             SlidableAction(
              //               borderRadius: BorderRadius.circular(5),
              //               onPressed: (context) {},
              //               backgroundColor: Colors.blue,
              //               foregroundColor: Colors.white,
              //               icon: Icons.edit,
              //               label: 'Edit',
              //             ),
              //           ],
              //         ),
              //         endActionPane: ActionPane(
              //           motion: const DrawerMotion(),
              //           children: [
              //             SlidableAction(
              //               borderRadius: BorderRadius.circular(5),
              //               onPressed: (context) {},
              //               backgroundColor: Colors.red,
              //               foregroundColor: Colors.white,
              //               icon: Icons.delete,
              //               label: 'Delete',
              //             ),
              //           ],
              //         ),
              //         child: ListTile(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) {
              //                   return TotalBill();
              //                 },
              //               ),
              //             );
              //           },
              //           leading: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text("Mar"),
              //               Text("13"),
              //             ],
              //           ),
              //           title: Text("Roti"),
              //           subtitle: Text("You paid Rs 400"),
              //           trailing: Column(
              //             children: [
              //               Text(
              //                 "You Lend",
              //                 style: TextStyle(color: Colors.green),
              //               ),
              //               Text(
              //                 "RS 500",
              //                 style: TextStyle(color: Colors.green),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.groupMembers!.length == 1
          ? SizedBox.shrink()
          : FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: Colors.black,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Split Money",
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}

class NoGroupWidget extends StatelessWidget {
  const NoGroupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          Text(
            "You are the only one in this group",
            style: GoogleFonts.aBeeZee(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20),
          // AppElevatedButton(
          //   text: "Add People",
          //   onPressed: () {
          //     BaseHelper.showFriendsBottomSheet(context);
          //   },
          // )

          const SizedBox(height: 10),

          // Already have an account
          Container(
            width: 280,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFBFFF60),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Add Members",
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
