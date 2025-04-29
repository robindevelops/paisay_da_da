import 'package:flutter/foundation.dart';
import 'package:paisay_da_da/domain/models/friendmodel/friend.model.dart';

class AddMemberNotifier extends ChangeNotifier {
  List<String> _members = [];
  List<String> get members => _members;

  FriendsModel _friendsModel = FriendsModel();
  FriendsModel get friendsModel => _friendsModel;

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
