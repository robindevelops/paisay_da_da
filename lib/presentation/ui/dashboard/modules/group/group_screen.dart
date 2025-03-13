import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/detail/detail_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/group/create_group_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';

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
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Add Group",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      child: Image.asset(Constants.stickman1),
                    ),
                    title: Text("Group Name"),
                    subtitle: Text("data"),
                    trailing: Text("no expense"),
                  );
                },
              ),
            ),

            // const Text(
            //   "Jitne marzi dost add kar lo…\npaisay wapas nahi milnay waalay!",
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.black,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // const SizedBox(height: 30),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 70.0),
            //   child: AppElevatedButton(
            //     text: "Start a Group",
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => CreategroupScreen(),
            //         ),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
