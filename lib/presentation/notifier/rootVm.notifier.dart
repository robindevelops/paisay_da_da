import 'package:flutter/material.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/friends/friends_request_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/group/main_group_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/home/home_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/profile/profile_screen.dart';

class Rootvm extends ChangeNotifier {
  int _currentindex = 0;
  int get currentindex => _currentindex;

  void changeIndex(int index) {
    _currentindex = index;
    notifyListeners();
  }

  List<Widget> _screens = [
    HomeScreen(),
    GroupScreen(),
    FriendRequest(),
    ProfileScreen(),
  ];

  List<Widget> get screens => _screens;
}
