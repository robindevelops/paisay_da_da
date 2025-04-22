import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({super.key});

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Friend Request"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   width: double.infinity,
          //   height: 50,
          //   decoration: BoxDecoration(
          //     color: Colors.black,
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Center(
          //     child: Text(
          //       "Friend Request",
          //       style: TextStyle(
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
          NoFriendRequestsFound(),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 2,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         onTap: () {},
          //         leading: CircleAvatar(
          //           child: Image.asset(
          //             Constants.stickman1,
          //           ),
          //         ),
          //         title: const Text("Furqan abid"),
          //         trailing: Row(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             IconButton(
          //               onPressed: () {},
          //               icon: Icon(
          //                 Icons.done,
          //                 color: Colors.green,
          //               ),
          //             ),
          //             IconButton(
          //               onPressed: () {},
          //               icon: Icon(
          //                 Icons.cancel_rounded,
          //                 color: Colors.red,
          //               ),
          //             )
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    final senderEmail = HiveDatabase.getValue(HiveDatabase.userKey);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add Friend",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              if (_emailController.text.isEmpty) {
                BaseHelper.showSnackBar(context, "Email required", Colors.red);
                return;
              }
            },
            child: const Text(
              "Send",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Enter email address',
              icon: Icons.email,
              controller: _emailController,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class NoFriendRequestsFound extends StatelessWidget {
  const NoFriendRequestsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Icon(
          //   Icons.person_off,
          //   size: 80,
          //   color: Colors.grey[400],
          // ),
          // const SizedBox(height: 20),
          const Text(
            "No Friend Requests Found",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "You're all caught up!",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
