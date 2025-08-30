import 'package:flutter/material.dart';

class SelectionNotifier extends ChangeNotifier {
  List _categories = [];

  List get categories => _categories;

  List _members = [];

  List get members => _members;
  final Map<String, List<Map<String, dynamic>>> _categorySections = {
    "Expenses": [
      // 🍔 Food & Drinks
      {"icon": Icons.fastfood, "title": "Groceries"},
      {"icon": Icons.local_dining, "title": "Restaurants"},
      {"icon": Icons.local_cafe, "title": "Coffee & Snacks"},
      {"icon": Icons.local_bar, "title": "Alcohol & Bars"},

      // 🛒 Shopping
      {"icon": Icons.shopping_bag, "title": "Clothing"},
      {"icon": Icons.devices, "title": "Electronics"},
      {"icon": Icons.shopping_cart, "title": "Online Shopping"},
      {"icon": Icons.style, "title": "Accessories"},

      // 🚗 Transport
      {"icon": Icons.directions_car, "title": "Fuel"},
      {"icon": Icons.directions_bus, "title": "Public Transport"},
      {"icon": Icons.local_taxi, "title": "Taxi & Ride-hailing"},
      {"icon": Icons.flight, "title": "Flights"},

      // 🏠 Housing & Utilities
      {"icon": Icons.home, "title": "Rent"},
      {"icon": Icons.house, "title": "Home Maintenance"},
      {"icon": Icons.lightbulb, "title": "Electricity"},
      {"icon": Icons.water, "title": "Water"},
      {"icon": Icons.wifi, "title": "Internet"},
      {"icon": Icons.phone, "title": "Phone Bill"},
      {"icon": Icons.fireplace, "title": "Gas"},

      // 🎉 Entertainment & Leisure
    ],
    "Outside": [
      {"icon": Icons.movie, "title": "Movies"},
      {"icon": Icons.music_note, "title": "Music"},
      {"icon": Icons.videogame_asset, "title": "Games"},
      {"icon": Icons.sports_soccer, "title": "Sports Events"},
      {"icon": Icons.festival, "title": "Events & Parties"},
    ],
    "  Health & Personal Care": [
      {"icon": Icons.local_hospital, "title": "Medical"},
      {"icon": Icons.healing, "title": "Pharmacy"},
      {"icon": Icons.fitness_center, "title": "Gym & Fitness"},
      {"icon": Icons.spa, "title": "Personal Care"},
    ],
    "Education & Learning": [
      {"icon": Icons.school, "title": "Tuition"},
      {"icon": Icons.book, "title": "Books"},
      {"icon": Icons.laptop_mac, "title": "Online Courses"},
    ],
    "Travel & Vacation": [
      {"icon": Icons.flight_takeoff, "title": "Flights"},
      {"icon": Icons.hotel, "title": "Hotels"},
      {"icon": Icons.directions_car, "title": "Car Rentals"},
      {"icon": Icons.attractions, "title": "Tourist Activities"},
    ],
    "Miscellaneous": [
      {"icon": Icons.business_center, "title": "Office Supplies"},
      {"icon": Icons.computer, "title": "Software Subscriptions"},
      {"icon": Icons.lunch_dining, "title": "Business Meals"},
    ],
    " Work & Business": [
      {"icon": Icons.miscellaneous_services, "title": "Charity & Donations"},
      {"icon": Icons.pets, "title": "Pets"},
      {"icon": Icons.family_restroom, "title": "Family"},
      {"icon": Icons.question_mark, "title": "Other"},
    ],
    "Income": [
      {"icon": Icons.work, "title": "Salary"},
      {"icon": Icons.card_giftcard, "title": "Gifts"},
      {"icon": Icons.trending_up, "title": "Investments"},
      {"icon": Icons.business, "title": "Business"},
      {"icon": Icons.handyman, "title": "Freelancing"},
      {"icon": Icons.monetization_on, "title": "Bonus"},
      {"icon": Icons.real_estate_agent, "title": "Rental Income"},
      {"icon": Icons.currency_exchange, "title": "Side Hustle"},
      {"icon": Icons.account_balance, "title": "Interest & Dividends"},
      {"icon": Icons.savings, "title": "Savings Withdrawals"},
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
