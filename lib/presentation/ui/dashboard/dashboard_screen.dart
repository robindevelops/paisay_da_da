import 'package:flutter/material.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/rootVm.notifier.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    Rootvm rootvm = context.watch<Rootvm>();
    final friendNotifier = context.watch<FriendNotifier>();

    return Scaffold(
      backgroundColor: Colors.white,
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
                label: "Friends",
                icon: Icon(Icons.person, size: 30),
              ),
              BottomNavigationBarItem(
                label: "Groups",
                icon: Icon(Icons.group, size: 30),
              ),
              BottomNavigationBarItem(
                label: "Requests",
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(Icons.face_5_sharp, size: 30),

                    // Badge
                    if (friendNotifier.pendingModel.data != null &&
                        friendNotifier.pendingModel.data!.isNotEmpty)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${friendNotifier.pendingModel.data!.length}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.account_circle, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
