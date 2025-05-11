import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/domain/models/friendmodel/friend.model.dart'
    as friend;
import 'package:paisay_da_da/presentation/animation/animation.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/detail/user_settings_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/expense/add_expense.dart';
import 'package:paisay_da_da/presentation/widgets/expense_tile.dart';
import 'package:paisay_da_da/presentation/widgets/no_expense_widget.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  String name;
  String email;
  List<friend.ExpenseDetail> expenseDetail;
  DetailScreen(
      {super.key,
      required this.name,
      required this.expenseDetail,
      required this.email});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void _navigateToAddExpenseScreen() {
    Navigator.of(context).push(
      AnimationUtil.circularRevealTransition(
        page: AddExpenseScreen(
          email: widget.email,
        ),
        centerAlignment: Alignment.bottomCenter,
        duration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        // centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(maxRadius: 25, backgroundColor: Colors.white),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                widget.expenseDetail.isNotEmpty
                    ? Container(
                        width: 70,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppThemes.highlightGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "${widget.expenseDetail.length} expense ",
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
                    return UserSettingsScreen();
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
          final userEmail = HiveDatabase.getValue(HiveDatabase.userKey);
        },
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: widget.expenseDetail.isEmpty
                  ? NoExpenseWidget(
                      message: 'No Expense yet with ${widget.name}',
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.expenseDetail.length,
                      itemBuilder: (context, index) {
                        final expense = widget.expenseDetail[index];
                        final expenseId = expense.sId;
                        final expenseAmount = expense.amount;
                        final amount = expenseAmount! ~/ 2;
                        final title = expense.expense?.title.toString();
                        final createdAt = expense.createdAt;
                        final payerName = expense.payer?.name.toString();
                        bool isPaidbyme = expense.payer?.email.toString() ==
                            HiveDatabase.getValue(HiveDatabase.userKey);

                        return ListTile(
                          title: Text(
                            title.toString(),
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        displayJustDate(
                                          createdAt.toString(),
                                        )['date']!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        displayJustDate(
                                          createdAt.toString(),
                                        )['month']!,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    height: 45,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        Constants.invoice,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: isPaidbyme
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'You Lend',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      'Rs,$amount',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'You owed',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      'Rs,$amount',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                          subtitle: isPaidbyme
                              ? Text("Paid by you")
                              : Text(
                                  "Paid by $payerName",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                        );
                      },
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
