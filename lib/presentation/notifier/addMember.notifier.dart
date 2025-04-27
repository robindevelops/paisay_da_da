import 'package:flutter/foundation.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:provider/provider.dart';

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

  void clearMemeber() {
    _members.clear();
  }

  bool isSelected(String email) => _members.contains(email);
}
