import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController memberController = TextEditingController();

  List<String> members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add an Expense",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Split Money",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.title),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(hintText: "Title"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.attach_money_rounded),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: "0.00"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Row(
            //   children: [
            //     Image.network(
            //       "https://cdn-icons-png.flaticon.com/128/8224/8224703.png",
            //       height: 50,
            //     ),
            //     const SizedBox(width: 20),
            //     Expanded(
            //       child: TextField(
            //         controller: descriptionController,
            //         decoration: InputDecoration(
            //           hintText: "Enter description...",
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 20),
            // Row(
            //   children: [
            //     Image.network(
            //       "https://cdn-icons-png.flaticon.com/128/12740/12740855.png",
            //       height: 50,
            //     ),
            //     const SizedBox(width: 20),
            //     Expanded(
            //       child: TextField(
            //         controller: amountController,
            //         keyboardType: TextInputType.number,
            //         decoration: InputDecoration(
            //           hintText: "0.00",
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 30),

            /// **New Section: Members List**
            Text(
              "Members Involved",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: members.length + 1,
                itemBuilder: (context, index) {
                  if (index == members.length) {
                    return GestureDetector(
                      onTap: () =>
                          BaseHelper.addTeamMembers(context, memberController),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add, color: Colors.black),
                            Text(" Add", style: GoogleFonts.poppins()),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(members[index],
                            style: GoogleFonts.poppins(color: Colors.white)),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              members.removeAt(index);
                            });
                          },
                          child:
                              Icon(Icons.close, color: Colors.white, size: 18),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),
            AppElevatedButton(
              text: "Paid by you split equally",
              onPressed: () => BaseHelper.showSplitOptions(context),
            ),
          ],
        ),
      ),
    );
  }
}
