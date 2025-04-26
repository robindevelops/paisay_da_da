import 'package:flutter/material.dart';

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
