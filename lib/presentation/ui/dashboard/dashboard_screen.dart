import 'package:flutter/material.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/load.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/rootVm.notifier.dart';

import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    LoaderNotifier loaderNotifier = context.read<LoaderNotifier>();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loaderNotifier.setLoading(true);

      final groupProvider = Provider.of<GroupNotifier>(context, listen: false);

      await groupProvider.getGroups(
        email: HiveDatabase.getValue(HiveDatabase.userKey),
      );

      loaderNotifier.setLoading(false);
    });
  }

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
