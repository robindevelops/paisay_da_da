import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';

class AddCategorieScreen extends StatefulWidget {
  const AddCategorieScreen({super.key});

  @override
  State<AddCategorieScreen> createState() => _AddCategorieScreenState();
}

class _AddCategorieScreenState extends State<AddCategorieScreen> {
  // Categories grouped by sections
  final Map<String, List<Map<String, dynamic>>> categorySections = {
    "Expenses": [
      {"icon": Icons.fastfood, "title": "Food"},
      {"icon": Icons.shopping_bag, "title": "Shopping"},
      {"icon": Icons.directions_car, "title": "Transport"},
      {"icon": Icons.home, "title": "Rent"},
      {"icon": Icons.movie, "title": "Entertainment"},
      {"icon": Icons.local_hospital, "title": "Health"},
      {"icon": Icons.school, "title": "Education"},
      {"icon": Icons.sports_soccer, "title": "Sports"},
      {"icon": Icons.flight, "title": "Travel"},
      {"icon": Icons.miscellaneous_services, "title": "Other"},
    ],
    "Income": [
      {"icon": Icons.work, "title": "Salary"},
      {"icon": Icons.card_giftcard, "title": "Gifts"},
      {"icon": Icons.trending_up, "title": "Investments"},
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        backgroundColor: Colors.white,
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
                      // fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Selected: ${category["title"]}")),
                    );
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
