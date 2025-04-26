import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/detail/total_bill.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(index),
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
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
            motion: const DrawerMotion(),
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
                      children: [
                        Text("Mar"),
                        Text("13"),
                      ],
                    ),
                    SizedBox(width: 10),
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
            title: Text("Roti"),
            subtitle: Text("You paid Rs 400"),
            trailing: Column(
              children: [
                Text(
                  "You Lend",
                  style: TextStyle(color: Colors.green),
                ),
                Text(
                  "RS 500",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
