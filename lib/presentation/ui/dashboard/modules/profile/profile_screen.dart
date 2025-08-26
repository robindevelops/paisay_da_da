import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/ui/auth/auth_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/profile/about.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/profile/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text("Profile"),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                _sectionTitle("Account", Icons.account_circle),
                ProfileListTile(
                  icon: "assets/icons/profile.svg",
                  title: "Edit Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(),
                      ),
                    );
                  },
                ),
                _sectionTitle(
                  "Notifications",
                  Icons.notifications_none_rounded,
                ),
                ProfileListTile(
                  icon: "assets/icons/privacy.svg",
                  title: "Notification",
                  isNotification: true,
                  onTap: () {},
                ),
                _sectionTitle(
                  "More",
                  Icons.collections_bookmark,
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
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: "assets/icons/logout.svg",
                  title: "Logout",
                  onTap: () {
                    HiveDatabase.storeValue("islogin", false);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthScreen(),
                      ),
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
  bool isNotification;
  final String icon;
  final String title;
  final VoidCallback onTap;

  ProfileListTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isNotification = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AddMemberNotifier addMemberNotifier =
    //     Provider.of<AddMemberNotifier>(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16),
      ),
      onTap: onTap,
      trailing: isNotification
          ? Switch(
              activeColor: Colors.white,
              activeTrackColor: AppThemes.splitGreen,
              inactiveThumbColor: Colors.white,
              // inactiveTrackColor: Colors.grey,
              value: false, // Replace with actual value from notifier
              onChanged: (value) {
                // addMemberNotifier.toggleNotification(value);
              },
            )
          : const Icon(
              CupertinoIcons.chevron_compact_right,
              color: Colors.black,
            ),
    );
  }
}
