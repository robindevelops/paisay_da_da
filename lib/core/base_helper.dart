import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseHelper {
  static void addTeamMembers(
      BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🏷️ Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add Team Members",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.cancel),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey[400]),

                  // 🔍 Search Field
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Search Members...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 👥 Fake List of Members
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: 5, // Mock 5 members
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(
                            "Member ${index + 1}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Add",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ✅ Done Button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static final List<String> splitOptions = [
    "Paid by me, split equally",
    "I owed full",
    "Paid by other",
    "Split money, I owed by others"
  ];

  static void showSplitOptions(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.black, // Black background
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: splitOptions
                .map(
                  (option) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: ListTile(
                      title: Text(
                        option,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white, // White text
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
