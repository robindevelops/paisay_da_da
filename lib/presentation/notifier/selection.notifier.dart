import 'package:flutter/material.dart';

class SelectionNotifier extends ChangeNotifier {
  List _categories = [];

  List get categories => _categories;

  List _members = [];

  List get members => _members;

  final Map<String, List<Map<String, dynamic>>> _categorySections = {
    "Expenses": [
      {"icon": Icons.fastfood, "title": "Food"},
      {"icon": Icons.shopping_bag, "title": "Shopping"},
      {"icon": Icons.directions_car, "title": "Transport"},
      {"icon": Icons.home, "title": "Rent"},
      {"icon": Icons.movie, "title": "Entertainment"},
      {"icon": Icons.local_hospital, "title": "Health"},
      {"icon": Icons.school, "title": "Education"},
      {"icon": Icons.sports_soccer, "title": "Sports"},
      {"icon": Icons.flight, "title": "Travel"},
      {"icon": Icons.miscellaneous_services, "title": "Other"},
    ],
    "Income": [
      {"icon": Icons.work, "title": "Salary"},
      {"icon": Icons.card_giftcard, "title": "Gifts"},
      {"icon": Icons.trending_up, "title": "Investments"},
    ]
  };

  Map<String, List<Map<String, dynamic>>> get categorySections =>
      _categorySections;

  void addCategory(
    String categoryName,
  ) {
    if (!_categories.contains(categoryName)) {
      _categories.add(categoryName);
      notifyListeners(); // notify UI about change
    }
  }

  void removeCategory(String categoryName) {
    if (_categories.remove(categoryName)) {
      notifyListeners();
    }
  }

  void addMember(String email) {
    if (!_members.contains(email)) {
      _members.add(email);
      notifyListeners();
    }
  }

  void removeMember(String email) {
    if (_members.remove(email)) {
      notifyListeners();
    }
  }

  void clear() {
    _categories.clear();
    _members.clear();
  }
}
