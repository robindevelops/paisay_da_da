import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/domain/models/groupmodel/group.model.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/detail/total_bill_screen.dart';

class ExpenseTile extends StatelessWidget {
  final List<ExpenseDetail>? expenseDetail; // Make it final

  ExpenseTile({super.key, required this.expenseDetail});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: expenseDetail!.length,
      itemBuilder: (context, index) {
        var expense = expenseDetail![index];
        var totalBill = expense.expense!.price;
        var expenseId = expense.expense?.sId;
        var createdAt = expense.createdAt;
        var expenseName = expense.expense?.title;
        var payerName = expense.payer?.name;
        var payerEmail = expense.payer?.email;
        var owedUsers = expense.owedUsers;
        var oweamount = expense.amount;
        var currentUser = HiveDatabase.getValue(HiveDatabase.userKey);
        bool isPaidByMe = currentUser == payerEmail;
        double totalLent = 0.0;

        expense.owedUsers?.forEach((owedUser) {
          totalLent += owedUser.amount ?? 0.0;
        });

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
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(5),
                onPressed: (context) {
                  print('Delete action for expense ID: $expenseId');
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              print(totalBill);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TotalBill(
                      createdAt: createdAt.toString(),
                      totalBill: totalBill.toString(),
                      payerName: payerName,
                      owedUsers: owedUsers,
                    );
                  },
                ),
              );
            },
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          displayJustDate(
                            createdAt.toString(),
                          )['month']!, // Second Text: Month
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 40,
                      child: Image.asset(
                        Constants.stickman1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            title: Text(expenseName!),
            subtitle: isPaidByMe
                ? Text(
                    'Paid by you',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  )
                : Text(
                    'Paid by ${payerName}',
                  ),
            trailing: SizedBox(
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isPaidByMe
                      ? LendMoneyWidget(totalLent: totalLent)
                      : OwedMoneyWidget(totalOwe: oweamount?.toInt()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LendMoneyWidget extends StatelessWidget {
  final double totalLent;

  const LendMoneyWidget({super.key, required this.totalLent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "You Lend",
          style: TextStyle(color: Colors.green, fontSize: 12),
        ),
        Text(
          "RS ${totalLent.toStringAsFixed(0)}",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class OwedMoneyWidget extends StatelessWidget {
  final int? totalOwe;

  const OwedMoneyWidget({super.key, required this.totalOwe});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "You Owe",
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
        Text(
          "RS ${totalOwe ?? 0}",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
} // Function to display both date and month separately

Map<String, String> displayJustDate(String date) {
  var dateLocal = DateTime.parse(date);
  return {
    'date': DateFormat("d").format(dateLocal), // Day of the month
    'month': DateFormat("MMMM").format(dateLocal), // Full month name
  };
}
