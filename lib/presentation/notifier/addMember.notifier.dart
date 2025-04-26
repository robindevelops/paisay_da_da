import 'package:flutter/foundation.dart';

class AddMemberNotifier extends ChangeNotifier {
  final List<String> _members = [];
  List<String> get members => _members;

  void toggleMember(String email) {
    if (_members.contains(email)) {
      _members.remove(email);
    } else {
      _members.add(email);
    }
    notifyListeners();
  }

  bool isSelected(String email) => _members.contains(email);
}
