import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/data/local/hive.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userName = HiveDatabase.getValue(HiveDatabase.userKey);
    const screenBackgroundColor = Colors.white;
    const primaryColor = Colors.blue;

    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: screenBackgroundColor,
                  backgroundImage: const NetworkImage(
                    "https://avatar.iran.liara.run/public",
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  userName,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                _sectionTitle("Account"),
                ProfileListTile(
                  icon: "assets/icons/profile.svg",
                  title: "Profile",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: "assets/icons/lock.svg",
                  title: "Change Password",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: "assets/icons/notification.svg",
                  title: "Notification Setting",
                  onTap: () {},
                ),
                _sectionTitle("More"),
                ProfileListTile(
                  icon: "assets/icons/privacy.svg",
                  title: "Privacy Policy",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: "assets/icons/language.svg",
                  title: "Language",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: "assets/icons/language.svg",
                  title: "Theme",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: "assets/icons/terms.svg",
                  title: "Terms & Conditions",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: "assets/icons/help.svg",
                  title: "Help",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: "assets/icons/delete.svg",
                  title: "Delete Account",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: "assets/icons/logout.svg",
                  title: "Logout",
                  onTap: () {
                    BaseHelper.showLogoutBottomSheet(context);
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const ProfileListTile({
    required this.icon,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap,
      trailing: const Icon(
        CupertinoIcons.right_chevron,
        color: Colors.black,
      ),
    );
  }
}
