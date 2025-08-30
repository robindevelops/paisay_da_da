import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/domain/models/accepted.request.model.dart';
import 'package:paisay_da_da/presentation/animation/animation.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/add/add_expense.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/friend/friend_settings_screen.dart';
import 'package:paisay_da_da/presentation/widgets/expense_tile.dart';

// ignore: must_be_immutable
class FriendDetailScreen extends StatefulWidget {
  List<ExpensesPaid> expensesPaid;
  List<ExpensesOwed> expensesOwed;
  String? firstName;

  FriendDetailScreen({
    required this.expensesPaid,
    required this.expensesOwed,
    required this.firstName,
  });

  @override
  State<FriendDetailScreen> createState() => _FriendDetailScreenState();
}

class _FriendDetailScreenState extends State<FriendDetailScreen> {
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
    var total =
        (widget.expensesPaid.length + widget.expensesOwed.length).toString();

    print(total);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        // centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: Image.asset(
                Constants.account,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  widget.firstName ?? "Unknown",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                int.parse(total) > 0
                    ? Container(
                        width: 70,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppThemes.highlightGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            total + ' expenses',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Text(
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
                    return FriendSettingsScreen();
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
                child: ExpenseTile(
                  expensesPaid: widget.expensesPaid,
                  expensesOwed: widget.expensesOwed,
                ),
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
