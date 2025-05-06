import 'package:flutter/foundation.dart';
import 'package:paisay_da_da/domain/models/friendmodel/friend.model.dart';

class AddMemberNotifier extends ChangeNotifier {
  List<String> _members = [];
  List<String> get members => _members;

  List<String> _leftGroup = [];
  List<String> get leftGroup => _leftGroup;

  FriendsModel _friendsModel = FriendsModel();
  FriendsModel get friendsModel => _friendsModel;

  bool _isOn = false;
  bool get isOn => _isOn;

  void toggleMember(String email) {
    if (_members.contains(email)) {
      _members.remove(email);
    } else {
      _members.add(email);
    }
    notifyListeners();
  }

  void toggleNotification(bool value) {
    _isOn = value;
    notifyListeners();
  }

  void addleftGroup(String name) {
    _leftGroup.add(name);
    notifyListeners();
  }

  void clearleftGroup(String name) {
    _leftGroup.clear();
    notifyListeners();
  }

  void clearMemeber() {
    _members.clear();
  }

  bool isSelected(String email) => _members.contains(email);
}
