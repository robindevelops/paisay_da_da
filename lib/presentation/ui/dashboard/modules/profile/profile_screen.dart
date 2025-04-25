import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/core/themes.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/profile/about.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userName = HiveDatabase.getValue(HiveDatabase.userKey);
    const screenBackgroundColor = Colors.white;
    const primaryColor = Colors.blue;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: screenBackgroundColor,
        title: const Text("Profile"),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: screenBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: 8),
                // CircleAvatar(
                //   radius: 50,
                //   backgroundColor: screenBackgroundColor,
                //   backgroundImage: const NetworkImage(
                //     "https://avatar.iran.liara.run/public",
                //   ),
                // ),
                // const SizedBox(height: 16),
                // Text(
                //   userName,
                //   style: TextStyle(
                //     color: primaryColor,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 18,
                //   ),
                // ),
                const SizedBox(height: 10),
                _sectionTitle("Account", Icons.account_circle),
                ProfileListTile(
                  icon: "assets/icons/profile.svg",
                  title: "Edit Profile",
                  onTap: () {},
                ),
                _sectionTitle(
                  "Notifications",
                  Icons.notifications_none_rounded,
                ),
                ProfileListTile(
                  icon: "assets/icons/privacy.svg",
                  title: "Notification",
                  onTap: () {},
                ),

                _sectionTitle(
                  "More",
                  Icons.collections_bookmark,
                ),
                ProfileListTile(
                  icon: "assets/icons/language.svg",
                  title: "Theme",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: "assets/icons/terms.svg",
                  title: "About Us",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUsScreen(),
                      ),
                    );
                  },
                ),

                ProfileListTile(
                  icon: "assets/icons/delete.svg",
                  title: "Delete Account",
                  onTap: () {
                    BaseHelper.showDBottomSheet(
                      context,
                      title: "Are you sure you want to delete your account?",
                      message: "Delete Account",
                      buttoncolor: Colors.red,
                    );
                  },
                ),
                ProfileListTile(
                  icon: "assets/icons/logout.svg",
                  title: "Logout",
                  onTap: () {
                    BaseHelper.showDBottomSheet(
                      context,
                      title: "Are you sure you want to logout?",
                      message: "logout",
                      buttoncolor: AppThemes.splitGreen,
                    );
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

  Widget _sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(
              size: 25,
              icon,
              color: Colors.black,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: GoogleFonts.aBeeZee(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
        style: GoogleFonts.poppins(fontSize: 16),
      ),
      onTap: onTap,
      trailing: const Icon(
        CupertinoIcons.chevron_compact_right,
        color: Colors.black,
      ),
    );
  }
}
