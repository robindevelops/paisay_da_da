import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/group/group_detail_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/group/create_group_screen.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              // print(value);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CreategroupScreen();
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: AppThemes.highlightGreen,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade700,
                ),
              ),
              child: Text(
                "Create Group",
                style: GoogleFonts.aBeeZee(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        backgroundColor: AppThemes.highlightGreen,
        color: Colors.black,
        onRefresh: () async {
          Future.delayed(
            const Duration(seconds: 1),
            () {},
          );
        },
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     vertical: MediaQuery.of(context).size.height / 4,
                //   ),
                //   child: AddGroupWidget(),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GroupDetailScreen(),
                            ),
                          );
                        },
                        title: Text("Group Name $index"),
                        leading: Image.asset(
                          scale: 13,
                          fit: BoxFit.cover,
                          Constants.account,
                        ),
                        trailing: Container(
                          width: 70,
                          height: 25,
                          decoration: BoxDecoration(
                            color: AppThemes.highlightGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "2 expenses",
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
