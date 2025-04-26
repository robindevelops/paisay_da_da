import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'package:paisay_da_da/core/themes.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/detail/total_bill.dart';
import 'package:paisay_da_da/presentation/widgets/no_expense_widget.dart';
import 'package:paisay_da_da/presentation/widgets/no_group_member_widget.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  String name;
  DetailScreen({super.key, required this.name});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
                Text(
                  "All khata clear ha",
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: 15,
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
            onPressed: () {},
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
              child: Center(
                child:
                    // ExpenseTile(),
                    NoExpenseWidget(
                  message: 'No Expense yet with ${widget.name}',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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
