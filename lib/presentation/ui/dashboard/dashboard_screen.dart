import 'package:flutter/material.dart';
import 'package:paisay_da_da/presentation/notifier/rootVm.notifier.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';

import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Rootvm rootvm = context.watch<Rootvm>();

    return Scaffold(
      // backgroundColor: AppThemes.appScaffoaldColor,
      body: IndexedStack(
        index: rootvm.currentindex,
        children: rootvm.screens,
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: rootvm.currentindex,
            onTap: (value) => rootvm.changeIndex(value),
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.6),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home, size: 30),
              ),
              BottomNavigationBarItem(
                label: "Groups",
                icon: Icon(Icons.group, size: 30),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                label: "Friends",
                icon: Icon(Icons.groups_2, size: 30),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.account_circle, size: 30),
              ),

              // BottomNavigationBarItem(
              //   label: "Profile",
              //   icon: Icon(Icons.person, size: 30),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
