import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController memberController = TextEditingController();

  final List<Map<String, String>> members = [
    {"name": "Muhammad Ahmad Cheema", "avatar": "assets/avatar1.png"},
    {"name": "Ali Khan", "avatar": "assets/avatar2.png"},
    {"name": "Zain Malik", "avatar": "assets/avatar3.png"}
  ];
  final List<String> selectedMembers = [];

  void _toggleMemberSelection(String member) {
    setState(() {
      if (selectedMembers.contains(member)) {
        selectedMembers.remove(member);
      } else {
        selectedMembers.add(member);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add an Expense", style: GoogleFonts.poppins()),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {}, // Add save functionality
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expense Title
              Text("Split Money",
                  style: GoogleFonts.aBeeZee(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Expense Details Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: "Enter Description",
                      icon: Icons.title,
                      controller: descriptionController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      hintText: "0.00",
                      icon: Icons.attach_money_outlined,
                      controller: amountController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text(
                "Members Involved",
                style: GoogleFonts.aBeeZee(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Members List
              Wrap(
                children: selectedMembers
                    .map(
                      (member) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: Chip(
                          backgroundColor: Colors.grey.shade100,
                          side: BorderSide(color: Colors.grey.shade300),
                          avatar: CircleAvatar(),
                          label: Text(member),
                          deleteIcon: Icon(Icons.close, size: 16),
                          onDeleted: () => _toggleMemberSelection(member),
                        ),
                      ),
                    )
                    .toList(),
              ),

              // Add Member Button
              GestureDetector(
                onTap: () {
                  // showModalBottomSheet(
                  //   context: context,
                  //   builder: (context) {
                  //     return Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: members
                  //           .map((member) => ListTile(
                  //                 leading: CircleAvatar(
                  //                     backgroundImage:
                  //                         AssetImage(member["avatar"]!)),
                  //                 title: Text(member["name"]!),
                  //                 trailing: Checkbox(
                  //                   value: selectedMembers
                  //                       .contains(member["name"]),
                  //                   onChanged: (bool? value) {
                  //                     _toggleMemberSelection(member["name"]!);
                  //                     Navigator.pop(context);
                  //                   },
                  //                 ),
                  //               ))
                  //           .toList(),
                  //     );
                  //   },
                  // );
                },
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Icon(Icons.add, color: Colors.black),
                      Text(
                        " Add",
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Split Button
              AppElevatedButton(
                text: "Paid by you split equally",
                onPressed: () => BaseHelper.showSplitOptions(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
