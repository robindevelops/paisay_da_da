import 'dart:math';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/detail/detail_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/expense/add_expense.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/friends/friends_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  void _navigateToAddExpenseScreen() {
    Navigator.of(context).push(
      PageRouteBuilder(
        barrierColor: Colors.black,
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          );

          return CircularRevealAnimation(
            animation: curvedAnimation,
            centerAlignment: Alignment.bottomCenter,
            child: const AddExpenseScreen(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FriendNotifier friendNotifier = context.watch<FriendNotifier>();
    GroupNotifier groupNotifier = context.watch<GroupNotifier>();
    var value = HiveDatabase.getValue(HiveDatabase.userKey);

    final List<String> stickmanImages = [
      Constants.stickman1,
      Constants.stickman2,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {},
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
          onRefresh: () async {
            await groupNotifier.getGroups(email: value);
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              friendNotifier.friendList.isEmpty
                  ? const NoFriendsWidget()
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
                          itemCount: friendNotifier.friendList.length,
                          itemBuilder: (context, index) {
                            final randomImage = stickmanImages[
                                Random().nextInt(stickmanImages.length)];

                            final friend = friendNotifier.friendList[index];

                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const DetailScreen(),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                child: Image.asset(randomImage),
                              ),
                              title: Text(friend.toString()),
                              trailing: const Text("No expense"),
                            );
                          },
                        ),
                      ],
                    )

              // const SizedBox(height: 20),
              // Text(
              //   "Pending Payment",
              //   style: GoogleFonts.aBeeZee(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 10),
              // Container(
              //   height: 90,
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(color: Colors.black),
              //   ),
              //   child: Row(
              //     children: [
              //       const CircleAvatar(),
              //       const SizedBox(width: 10),
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             const Text(
              //               "Furqan Abid",
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             const SizedBox(height: 5),
              //             Text(
              //               "\$120.00 due by Aug 25",
              //               style: GoogleFonts.aBeeZee(
              //                 fontSize: 14,
              //                 color: Colors.green,
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
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _navigateToAddExpenseScreen,
      //   backgroundColor: Colors.black,
      //   icon: const Icon(Icons.add, color: Colors.white),
      //   label: const Text(
      //     "Split Money",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
    );
  }
}

class NoFriendsWidget extends StatelessWidget {
  const NoFriendsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.person_2_rounded, size: 50, color: Colors.black),
          const SizedBox(height: 20),
          Text(
            "Dost nahi mile? Tum bhi developer ho kya?",
            style: GoogleFonts.aBeeZee(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "Kisi ko add karo warna app bhi udaas ho jayegi",
            style: GoogleFonts.aBeeZee(
              fontSize: 13,
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
    );
  }
}
