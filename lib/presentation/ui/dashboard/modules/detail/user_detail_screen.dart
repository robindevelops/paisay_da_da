import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/domain/models/friendmodel/friend.model.dart'
    as friend;
import 'package:paisay_da_da/presentation/animation/animation.dart';
import 'package:paisay_da_da/presentation/notifier/expense.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/detail/user_settings_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/expense/add_expense.dart';
import 'package:paisay_da_da/presentation/widgets/expense_tile.dart';
import 'package:paisay_da_da/presentation/widgets/no_expense_widget.dart';
import 'package:provider/provider.dart';

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
    final personalExpenses = widget.expenseDetail
        .where((expense) => expense.expenseType == 'personal')
        .toList();

    ExpenseNotifier expenseNotifier = Provider.of<ExpenseNotifier>(context);
    FriendNotifier friendNotifier = Provider.of<FriendNotifier>(context);

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
                  widget.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                personalExpenses.isNotEmpty
                    ? Container(
                        width: 70,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppThemes.highlightGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "${personalExpenses.length} expense ",
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
              child: personalExpenses.isEmpty
                  ? NoExpenseWidget(
                      message: 'No Expense yet with ${widget.name}',
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: personalExpenses.length,
                      itemBuilder: (context, index) {
                        final expense = personalExpenses[index];
                        final expenseAmount = expense.price;
                        final expenseId = expense.expenseId;
                        final amount = int.parse(expenseAmount!) / 2;
                        final title = expense.title.toString();
                        final createdAt = expense.date;
                        final payerName = expense.payer?.toString();
                        bool isPaidbyme = expense.email.toString() ==
                            HiveDatabase.getValue(HiveDatabase.userKey);

                        return Slidable(
                          key: ValueKey(index),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                borderRadius: BorderRadius.circular(5),
                                onPressed: (context) {},
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                            ],
                          ),
                          endActionPane: isPaidbyme
                              ? ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      borderRadius: BorderRadius.circular(5),
                                      onPressed: (context) {
                                        expenseNotifier.clearExpenese(
                                          expenseId: expenseId.toString(),
                                          context: context,
                                        );

                                        friendNotifier.getFriends(
                                          context: context,
                                          email: HiveDatabase.getValue(
                                              HiveDatabase.userKey),
                                        );
                                        Navigator.pop(context);
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                )
                              : null,
                          child: ListTile(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
