import 'dart:math';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'package:paisay_da_da/core/themes.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/detail/detail_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/expense/add_expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  void _navigateToAddExpenseScreen() {
    // _animationController.forward(from: 0.0);

    Navigator.of(context).push(
      PageRouteBuilder(
        barrierColor: Colors.black,
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          );

          return CircularRevealAnimation(
            animation: curvedAnimation,
            centerAlignment: Alignment.bottomCenter,
            child: const AddExpenseScreen(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            // Text(
            //   "Hello",
            //   style: GoogleFonts.aBeeZee(
            //     fontSize: 13,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black,
            //   ),
            // ),
            // SizedBox(height: 5),
            // Text(
            //   "Alyan",
            //   style: GoogleFonts.aBeeZee(
            //     fontSize: 20,
            //     fontWeight: FontWeight.w600,
            //     color: Colors.grey[800],
            //   ),
            // ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          )
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
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    final List<String> stickmanImages = [
                      Constants.stickman1,
                      Constants.stickman2,
                    ];

                    final randomImage =
                        stickmanImages[Random().nextInt(stickmanImages.length)];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const DetailScreen();
                            },
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        child: Image.asset(randomImage),
                      ),
                      title: const Text("Furqan abid"),
                      trailing: const Text("No expense"),
                    );
                  },
                ),
              ),
              // Text(
              //   "Pending Payment",
              //   style: GoogleFonts.aBeeZee(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 10),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: 1,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         height: 90,
              //         width: double.infinity,
              //         padding: EdgeInsets.symmetric(
              //           horizontal: 12,
              //           vertical: 10,
              //         ),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(color: Colors.black),
              //         ),
              //         child: Row(
              //           children: [
              //             CircleAvatar(),
              //             SizedBox(width: 10),
              //             Expanded(
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     "Furqan Abid",
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                   SizedBox(height: 5),
              //                   Text(
              //                     "\$120.00 due by Aug 25",
              //                     style: GoogleFonts.aBeeZee(
              //                       fontSize: 14,
              //                       color: Colors.green,
              //                     ),
              //                   ),
              //                 ],
              //               ),
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
        onPressed: _navigateToAddExpenseScreen,
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
