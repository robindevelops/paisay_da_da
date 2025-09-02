import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/domain/models/accepted.request.model.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/total/total_bill_screen.dart';
import 'package:paisay_da_da/presentation/widgets/no_expense_widget.dart';

class ExpenseTile extends StatelessWidget {
  final List<ExpensesPaid> expensesPaid;
  final List<ExpensesOwed> expensesOwed;

  const ExpenseTile({
    super.key,
    required this.expensesPaid,
    required this.expensesOwed,
  });

  @override
  Widget build(BuildContext context) {
    final combinedExpenses = [
      ...expensesPaid.map((e) => {"type": "lend", "data": e}),
      ...expensesOwed.map((e) => {"type": "owe", "data": e}),
    ];

    return combinedExpenses.isEmpty
        ? NoExpenseWidget(message: "No Expense with this friend")
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: combinedExpenses.length,
            itemBuilder: (context, index) {
              final item = combinedExpenses[index];
              final type = item["type"] as String;
              String title;
              String created;
              String totalbill;
              String payerName;
              String oweduser;
              int amount = 0;

              if (type == "lend") {
                final expense = item["data"] as ExpensesPaid;
                title = expense.title ?? "Expense";
                created = expense.createdAt ?? "";
                amount = ((expense.amount ?? 0) / 2).round();
              } else {
                final expense = item["data"] as ExpensesOwed;
                title = expense.title ?? "Expense";
                created = expense.createdAt ?? "";
                amount = ((expense.amount ?? 0) / 2).round();
              }

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
                      label: "Edit",
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      borderRadius: BorderRadius.circular(5),
                      onPressed: (context) {},
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TotalBill(),
                      ),
                    );
                  },
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            displayJustDate(created)['date'] ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            displayJustDate(created)['month'] ?? "",
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Container(
                        height: 45,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
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
                  title: Text(title),
                  subtitle: Text(
                    type == "lend" ? "You Owe" : "You Lend",
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: SizedBox(
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (type == "lend")
                          OwedMoneyWidget(totalOwe: amount)
                        else
                          LendMoneyWidget(totalLent: amount.toDouble())
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
        const Text(
          "You Lend",
          style: TextStyle(color: Colors.green, fontSize: 12),
        ),
        Text(
          "RS ${totalLent.toStringAsFixed(0)}",
          style: const TextStyle(
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
        const Text(
          "You Owe",
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
        Text(
          "RS ${totalOwe ?? 0}",
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

Map<String, String> displayJustDate(String date) {
  final dateLocal = DateTime.parse(date);
  return {
    'date': DateFormat("d").format(dateLocal),
    'month': DateFormat("MMM").format(dateLocal),
  };
}
