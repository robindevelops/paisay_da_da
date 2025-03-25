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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CreategroupScreen();
                  },
                ),
              );
            },
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
                // scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
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
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(Constants.stickman1),
                          radius: 15,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(Constants.stickman2),
                          radius: 15,
                        ),
                      ],
                    ),
                    title: const Text("Shareef Log"),
                    subtitle: const Text("5 members"),
                    trailing: const Text("No expense"),
                  );
                },
              ),
            ),
            // Expanded(
            //     child: GridView.builder(
            //   gridDelegate:
            //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            //   itemBuilder: (context, index) {
            //     return Container(
            //       margin: EdgeInsets.all(20),
            //       width: 50,
            //       height: 100,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: Colors.grey[350]!),
            //         borderRadius: BorderRadius.circular(20),
            //         color: Colors.grey[100]!,
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text("Group Name"),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // ))

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
