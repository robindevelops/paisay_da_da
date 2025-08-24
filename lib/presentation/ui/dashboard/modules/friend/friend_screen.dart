import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/presentation/animation/animation.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/add/add_expense.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/add/add_friends_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/friend/friend_detail_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen>
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
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // leading: CircleAvatar(),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddFriendScreen();
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Add friend",
                style: GoogleFonts.aBeeZee(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
          onRefresh: () async {},
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     vertical: MediaQuery.of(context).size.height / 4,
              //   ),
              //   child: NoFriendsWidget(),
              // ),
              Column(
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
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FriendDetailScreen(),
                            ),
                          );
                        },
                        leading: Image.asset(
                          Constants.account,
                          scale: 13,
                          fit: BoxFit.cover,
                        ),
                        title: Text("All"),
                        trailing: Container(
                          width: 70,
                          height: 25,
                          decoration: BoxDecoration(
                            color: AppThemes.highlightGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "2 expenses",
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
      floatingActionButton: FloatingActionButton.extended(
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
            // const Icon(Icons.person_2_rounded, size: 50, color: Colors.black),
            // const SizedBox(height: 20),
            Text(
              "Add karo, warna app ki\nfeeling off ho jayegi!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
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
