import 'package:flutter/material.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';

class FriendScreen extends StatefulWidget {
  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Friends",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TabBar(
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.grey,
                indicator: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(25),
                  // Rounded indicator
                ),
                tabs: [
                  Tab(text: "Friends"),
                  Tab(text: "Suggestions"),
                  Tab(text: "Pending"),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Friends List"),
                // AppElevatedButton(
                //   text: "Add Friend",
                //   onPressed: () {},
                // )
              ],
            ),
            Center(
              child: Text("Friend Suggestions"),
            ),
            Center(
              child: Text("Pending Requests"),
            ),
          ],
        ),
      ),
    );
  }
}
