import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/detail/detail_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/expense/add_expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Add friend",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Gareeb Dost",
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    final List<String> stickmanImages = [
                      Constants.stickman1,
                      Constants.stickman2,
                      // Constants.stickman3,
                    ];

                    final randomImage =
                        stickmanImages[Random().nextInt(stickmanImages.length)];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailScreen();
                            },
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        child: Image.asset(randomImage),
                      ),
                      title: Text("Furqan abid 🔥${23}"),
                      trailing: Text("no expense"),
                    );
                  },
                ),
              )
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: 1,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         margin: const EdgeInsets.symmetric(
              //             horizontal: 16, vertical: 8),
              //         padding: const EdgeInsets.all(16),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(12),
              //           border: Border.all(color: Colors.black),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black.withOpacity(0.2),
              //               blurRadius: 5,
              //               spreadRadius: 1,
              //               offset: const Offset(0, 3),
              //             ),
              //           ],
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             // Person who paid
              //             Row(
              //               children: [
              //                 CircleAvatar(
              //                   backgroundColor: Colors.black,
              //                   child: Icon(Icons.person, color: Colors.black),
              //                 ),
              //                 const SizedBox(width: 10),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     const Text(
              //                       "Ali paid",
              //                       style: TextStyle(
              //                         color: Colors.black,
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                     const Text(
              //                       "₹1500",
              //                       style: TextStyle(
              //                         color: Colors.greenAccent,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),

              //             // Amount pending
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               children: [
              //                 const Text(
              //                   "You owe",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 14,
              //                   ),
              //                 ),
              //                 const Text(
              //                   "₹500",
              //                   style: TextStyle(
              //                     color: Colors.redAccent,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddExpenseScreen();
              },
            ),
          );
        },
        backgroundColor: Colors.black,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Split Money",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
