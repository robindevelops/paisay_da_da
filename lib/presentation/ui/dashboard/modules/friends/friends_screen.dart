import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/constants.dart';

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
                  Tab(text: "Pending"),
                  Tab(text: "Friend Request"),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Friends(),
            PendingRequestsScreen(),
            FriendRequest(),
          ],
        ),
      ),
    );
  }
}

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return "Enter a valid email";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Send Friend via email",
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("object");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Friend request send"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                    ;
                  },
                  icon: Icon(Icons.send),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text("No Friends"),
            ),
          ],
        ),
      ),
    );
  }
}

class PendingRequestsScreen extends StatefulWidget {
  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pending"),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      child: Image.asset(
                        Constants.stickman1,
                      ),
                    ),
                    title: const Text("Furqan abid"),
                    trailing: const Text("pending request"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendRequest extends StatefulWidget {
  const FriendRequest({super.key});

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Friend Request"),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      child: Image.asset(
                        Constants.stickman1,
                      ),
                    ),
                    title: const Text("Furqan abid"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.done,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.cancel_rounded,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
