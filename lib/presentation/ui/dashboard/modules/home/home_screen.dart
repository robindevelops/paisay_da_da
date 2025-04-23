import 'dart:math';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'package:paisay_da_da/core/themes.dart';
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
    GroupNotifier groupNotifier = context.watch<GroupNotifier>();
    final userEmail = HiveDatabase.getValue(HiveDatabase.userKey);

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
            onPressed: () {
              print(userEmail);
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
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              const NoFriendsWidget()
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       "Gareeb Dost",
              //       style: GoogleFonts.aBeeZee(
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     const SizedBox(height: 10),
              //     ListView.builder(
              //       shrinkWrap: true,
              //       physics: const NeverScrollableScrollPhysics(),
              //       itemCount: 2,
              //       itemBuilder: (context, index) {
              //         final randomImage = stickmanImages[
              //             Random().nextInt(stickmanImages.length)];

              //         return ListTile(
              //           contentPadding: const EdgeInsets.symmetric(
              //             vertical: 10,
              //           ),
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (_) => const DetailScreen(),
              //               ),
              //             );
              //           },
              //           leading: CircleAvatar(
              //             child: Image.asset(randomImage),
              //           ),
              //           title: Text("furqan abid"),
              //           trailing: const Text("No expense"),
              //         );
              //       },
              //     ),
              //   ],
              // ),
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
              //       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              //   decoration: BoxDecoration(
              //     color: Colors.black,
              //     borderRadius: BorderRadius.circular(16),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.2),
              //         blurRadius: 10,
              //         offset: const Offset(0, 4),
              //       ),
              //     ],
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
              //                 color: Colors.white,
              //               ),
              //             ),
              //             const SizedBox(height: 6),
              //             Text(
              //               "\$120.00 due by Aug 25",
              //               style: GoogleFonts.aBeeZee(
              //                 fontSize: 14,
              //                 color: Colors.white.withOpacity(0.9),
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
      //   backgroundColor: AppThemes.highlightGreen,
      //   icon: const Icon(Icons.add, color: Colors.black),
      //   label: const Text(
      //     "Split Money",
      //     style: TextStyle(color: Colors.black),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            const Icon(Icons.person_2_rounded, size: 50, color: Colors.black),
            const SizedBox(height: 20),
            Text(
              "Friends!",
              style: GoogleFonts.dancingScript(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
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
