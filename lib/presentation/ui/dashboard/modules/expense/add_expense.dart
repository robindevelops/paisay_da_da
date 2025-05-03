// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/base_helper.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/addMember.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/expense.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/friends/add_members_screen.dart';
import 'package:provider/provider.dart';
import 'package:simple_animated_button/elevated_layer_button.dart';

class AddExpenseScreen extends StatefulWidget {
  List<String>? groupMembers;
  String? groupid;
  String? name;

  AddExpenseScreen({
    super.key,
    this.groupMembers,
    this.groupid,
    this.name,
  });

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final payerEmail = HiveDatabase.getValue(HiveDatabase.userKey);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ExpenseNotifier expenseNotifier = Provider.of<ExpenseNotifier>(context);
    GroupNotifier groupNotifier = Provider.of<GroupNotifier>(context);
    AddMemberNotifier addMemberNotifier =
        Provider.of<AddMemberNotifier>(context);

    // Filter out the payer from the member list
    final members = (widget.groupMembers ?? []).where((member) {
      return member != payerEmail;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add an expense",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
              addMemberNotifier.clearMemeber();
            }),
        actions: [
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await expenseNotifier.addExpenese(
                  title: descriptionController.text,
                  price: amountController.text,
                  payerEmail: payerEmail,
                  members: members,
                  context: context,
                  groupId: widget.groupid,
                );

                await groupNotifier.getGroups(email: payerEmail);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
              print(members);
              print(addMemberNotifier.members);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Discription is required";
                  }
                  return null;
                },
                controller: descriptionController,
                hintText: "Enter Description",
                icon: Icons.description_outlined,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Amount is required";
                  }
                  return null;
                },
                controller: amountController,
                hintText: "0.00",
                icon: Icons.attach_money_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              Text(
                "Add members",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              (widget.groupMembers != null && widget.groupMembers!.isNotEmpty)
                  ? Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.black,
                      label: Text(
                        'All members of ${widget.name}',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        // +Add button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddMembersScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.add, size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  "Add",
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Member chips
                        ...addMemberNotifier.members.map((member) {
                          return Chip(
                            label: Text(
                              getUsernameFromEmail(member),
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black,
                            deleteIcon:
                                const Icon(Icons.close, color: Colors.white),
                            onDeleted: () {
                              addMemberNotifier.toggleMember(member);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
              const SizedBox(height: 30),

              // Text(
              //   "Paid by you split equally",
              //   style: GoogleFonts.poppins(
              //     fontSize: 16,
              //     color: Colors.black,
              //   ),
              // ),

              Center(
                child: Transform.rotate(
                  angle: -0.04,
                  child: Container(
                    color: const Color(0xFFCFFF00),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      "Paid by me split equally",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedLayerButton(
                  onClick: () => BaseHelper.showSplitOptions(context),
                  buttonHeight: 60,
                  buttonWidth: 270,
                  animationDuration: const Duration(milliseconds: 200),
                  animationCurve: Curves.ease,
                  topDecoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(),
                  ),
                  topLayerChild: Text(
                    "Split Option",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  baseDecoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

String getUsernameFromEmail(String email) {
  return email.split('@')[0].toUpperCase();
}
