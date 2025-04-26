import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

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
    FriendNotifier friendNotifier = Provider.of<FriendNotifier>(context);
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
            onPressed: () async {
              if (_emailController.text.isEmpty) {
                BaseHelper.showSnackBar(context, "Email required", Colors.red);
                return;
              }

              return await friendNotifier.addFriend(
                senderEmail: senderEmail,
                receiverEmail: _emailController.text,
                context: context,
              );
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
