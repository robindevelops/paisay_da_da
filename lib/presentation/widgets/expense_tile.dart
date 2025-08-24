import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:paisay_da_da/core/constants/constants.dart';

import 'package:paisay_da_da/presentation/ui/dashboard/modules/total/total_bill_screen.dart';

class ExpenseTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
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
                  builder: (context) {
                    return TotalBill();
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
                        Text("12"),
                        Text("Aug"),
                      ],
                    ),
                    const SizedBox(width: 15),
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
            title: Text("Shopping"),
            subtitle: Text(
              'Paid by you',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            //  Text(
            //     'Paid by ${payerName}',
            //   ),
            trailing: SizedBox(
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LendMoneyWidget(totalLent: 2),
                  // OwedMoneyWidget(totalOwe: 2),
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
