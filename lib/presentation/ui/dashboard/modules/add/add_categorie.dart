// AddCategorieScreen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/presentation/notifier/selection.notifier.dart';
import 'package:provider/provider.dart';

class AddCategorieScreen extends StatefulWidget {
  const AddCategorieScreen({super.key});

  @override
  State<AddCategorieScreen> createState() => _AddCategorieScreenState();
}

class _AddCategorieScreenState extends State<AddCategorieScreen> {
  @override
  Widget build(BuildContext context) {
    var selectionNotifier =
        Provider.of<SelectionNotifier>(context, listen: false);

    final categorySections = selectionNotifier.categorySections;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: categorySections.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Heading
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  entry.key, // Section name
                  style: GoogleFonts.aBeeZee(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Categories under the section
              ...entry.value.map((category) {
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: AppThemes.highlightGreen.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      category["icon"],
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    category["title"],
                    style: GoogleFonts.aBeeZee(
                      fontSize: 17,
                      color: Colors.black87,
                    ),
                  ),
                  onTap: () {
                    selectionNotifier.addCategory(category["title"]);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
