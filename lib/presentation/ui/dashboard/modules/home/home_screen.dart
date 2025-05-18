import 'dart:math';

import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/animation/animation.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/detail/user_detail_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/expense/add_expense.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/friends/add_friends_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/friends/add_members_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  void _navigateToAddExpenseScreen() {
    Navigator.of(context).push(
      AnimationUtil.circularRevealTransition(
        page: AddExpenseScreen(),
        centerAlignment: Alignment.bottomCenter,
        duration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    GroupNotifier groupNotifier = context.watch<GroupNotifier>();
    FriendNotifier friendNotifier = context.watch<FriendNotifier>();
    final userEmail = HiveDatabase.getValue(HiveDatabase.userKey);

    final List<String> stickmanImages = [
      Constants.stickman1,
      Constants.stickman2,
    ];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              print(userEmail);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddFriendScreen();
                  },
                ),
              );
            },
            child: Text(
              "Add friend",
              style: GoogleFonts.aBeeZee(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: AppThemes.highlightGreen,
          color: Colors.black,
          onRefresh: () async {
            await groupNotifier.getGroups(email: userEmail);
            await friendNotifier.getFriends(email: userEmail, context: context);
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              friendNotifier.friends.isEmpty
                  ? NoFriendsWidget()
                  // : Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "You owed \$0.00",
                  //         style: GoogleFonts.aBeeZee(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.orange,
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //       const SizedBox(width: 16),
                  //       Container(
                  //         height: 20,
                  //         width: 1,
                  //         color: Colors.black.withOpacity(0.6),
                  //       ),
                  //       const SizedBox(width: 16),
                  //       Text(
                  //         "You are owed \$0.00",
                  //         style: GoogleFonts.aBeeZee(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.green,
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ],
                  //   ),

                  // const SizedBox(height: 25),

                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gareeb Dost",
                          style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: friendNotifier.friends.length,
                          itemBuilder: (context, index) {
                            var friend = friendNotifier.friends[index];
                            var name = friend.name;
                            var email = friend.email;
                            var expenseDetail = friend.expenseDetail;
                            final personalExpenses = expenseDetail
                                ?.where((expense) =>
                                    expense.expenseType == 'personal')
                                .toList();

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailScreen(
                                      name: name.toString(),
                                      expenseDetail: expenseDetail ?? [],
                                      email: email.toString(),
                                    ),
                                  ),
                                );
                              },
                              leading: Image.asset(
                                Constants.account,
                                scale: 13,
                                fit: BoxFit.cover,
                              ),
                              title: Text(name.toString()),
                              trailing: personalExpenses!.isEmpty
                                  ? Text("No expense")
                                  : Container(
                                      width: 70,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: AppThemes.highlightGreen,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${personalExpenses.length} expense",
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
              // const SizedBox(height: 20),
              // Text(
              //   "Pending Payment",
              //   style: GoogleFonts.aBeeZee(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 20),
              // Container(
              //   height: 90,
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 16,
              //     vertical: 12,
              //   ),
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: Colors.black,
              //       width: 1,
              //     ),
              //     color: Colors.grey[100],
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Row(
              //     children: [
              //       const CircleAvatar(
              //         radius: 25,
              //         backgroundColor: Color(0xFFD0FF4B),
              //         child: Icon(Icons.person, color: Colors.black),
              //       ),
              //       const SizedBox(width: 14),
              //       Expanded(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               "Furqan Abid",
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //                 color: Colors.black,
              //               ),
              //             ),
              //             const SizedBox(height: 6),
              //             Text(
              //               "\$120.00 due by Aug 25",
              //               style: GoogleFonts.aBeeZee(
              //                 fontSize: 14,
              //                 color: Colors.black,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: friendNotifier.friends.isEmpty
          ? SizedBox.shrink()
          : FloatingActionButton.extended(
              onPressed: _navigateToAddExpenseScreen,
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

class NoFriendsWidget extends StatelessWidget {
  const NoFriendsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            const Icon(Icons.person_2_rounded, size: 50, color: Colors.black),
            const SizedBox(height: 20),
            Text(
              "Add karo, warna app ki feeling off ho jayegi!",
              style: GoogleFonts.patrickHand(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            AppElevatedButton(
              text: "Add Friend",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFriendScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
