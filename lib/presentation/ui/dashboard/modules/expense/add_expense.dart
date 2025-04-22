import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:simple_animated_button/bouncing_button.dart';
import 'package:simple_animated_button/elevated_layer_button.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

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
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {}, // Implement save logic
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField(
              controller: descriptionController,
              hintText: "Enter Description",
              icon: Icons.description_outlined,
            ),
            const SizedBox(height: 20),
            _buildInputField(
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
            GestureDetector(
              onTap: () => BaseHelper.showFriendsBottomSheet(context),
              child: Container(
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "+Add",
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
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
