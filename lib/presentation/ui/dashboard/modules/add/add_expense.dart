// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/add/add_categorie.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/add/add_members_screen.dart';

class AddExpenseScreen extends StatefulWidget {
  List<String>? groupMembers;
  String? groupid;
  String? name;
  String? email;

  AddExpenseScreen({
    super.key,
    this.groupMembers,
    this.groupid,
    this.name,
    this.email,
  });

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  List<String> selectedMembers = [];

  @override
  Widget build(BuildContext context) {
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
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // For now just debug print
                print("Expense Title: ${descriptionController.text}");
                print("Amount: ${amountController.text}");
                print("Members: $selectedMembers");

                Navigator.pop(context); // back to prev screen
              }
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Description is required";
                            }
                            return null;
                          },
                          controller: descriptionController,
                          hintText: "Expense Title",
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

                        // Add Members Section
                        Text(
                          "Add members",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            // +Add button
                            GestureDetector(
                              onTap: () async {
                                // Navigate to AddMembersScreen
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddMembersScreen(),
                                  ),
                                );

                                if (result != null && result is List<String>) {
                                  setState(() {
                                    selectedMembers.addAll(result);
                                  });
                                }
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
                            ...selectedMembers.map(
                              (member) {
                                return Chip(
                                  label: Text(
                                    getUsernameFromEmail(member),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.black,
                                  deleteIcon: const Icon(
                                    Icons.close,
                                    color: AppThemes.highlightGreen,
                                  ),
                                  onDeleted: () {
                                    setState(() {
                                      selectedMembers.remove(member);
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Categorie",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddCategorieScreen();
                                },
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

                        const SizedBox(height: 30),
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
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
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
