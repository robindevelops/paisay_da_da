import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/core/socket.io.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/presentation/animation/animation.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/add/add_expense.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/add/add_friends_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/friend/friend_detail_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:provider/provider.dart';

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

  late SocketService socket;
  late FriendNotifier friendNotifier;

  @override
  void initState() {
    super.initState();

    socket = SocketService();
    // we don't have access to context.watch here, so use addPostFrameCallback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      friendNotifier = Provider.of<FriendNotifier>(context, listen: false);

      socket.socket.on("friendRequestReceived", (data) async {
        await friendNotifier.pendingRequest(context);
        await friendNotifier.acceptedRequest(context);
      });

      socket.socket.on("expenseAdded", (data) async {
        await friendNotifier.acceptedRequest(context);
      });

      // fetch pending list initially
      friendNotifier.pendingRequest(context);
      friendNotifier.acceptedRequest(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var friendNotifier = Provider.of<FriendNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
                color: AppThemes.highlightGreen,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade700,
                ),
              ),
              child: Text(
                "Add friend",
                style: GoogleFonts.aBeeZee(
                  fontSize: 13,
                  color: Colors.black,
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
          onRefresh: () async {
            // await friendNotifier.pendingRequest(context);
            await friendNotifier.acceptedRequest(context);
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              friendNotifier.acceptedModel.data == null ||
                      friendNotifier.acceptedModel.data!.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 4,
                      ),
                      child: NoFriendsWidget(),
                    )
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
                          itemCount: friendNotifier.acceptedModel.data?.length,
                          itemBuilder: (context, index) {
                            final friend =
                                friendNotifier.acceptedModel.data![index];

                            var total =
                                (friend.friend?.expensesOwed?.length ?? 0) +
                                    (friend.friend?.expensesPaid?.length ?? 0);

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FriendDetailScreen(
                                      firstName: friend.friend?.firstName,
                                      expensesPaid:
                                          friend.friend?.expensesPaid ?? [],
                                      expensesOwed:
                                          friend.friend?.expensesOwed ?? [],
                                    ),
                                  ),
                                );
                              },
                              leading: Image.asset(
                                Constants.account,
                                scale: 13,
                                fit: BoxFit.cover,
                              ),
                              title: Text(friend.friend?.firstName ?? "Unkown"),
                              trailing: total != 0
                                  ? Container(
                                      width: 70,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: AppThemes.highlightGreen,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$total expenses',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "No expense",
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: friendNotifier.acceptedModel.data == null ||
              friendNotifier.acceptedModel.data!.isEmpty
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
