import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/domain/models/groupmodel/group.model.dart';
import 'package:paisay_da_da/domain/repository/group.repository.dart';

class GroupNotifier extends ChangeNotifier {
  final GroupRepository groupRepository;

  GroupModel _groupModel = GroupModel(groups: []);

  GroupModel get groupModel => _groupModel;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  GroupNotifier({required this.groupRepository});

  Future<void> createGroup({
    required String createdBy,
    required String groupName,
    required List<String> members,
    required BuildContext context,
  }) async {
    var response = await groupRepository.createGroup(
      groupName: groupName,
      members: members,
      createdBy: createdBy,
    );

    response.fold(
      (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Group created successfully ✅"),
            backgroundColor: Colors.green,
          ),
        );
      },
      (failure) {
        String message = (failure.message == 'Group already exists.')
            ? "Group already exists ❌"
            : "Failed to create group ❌";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }

  Future<void> getGroups({required String email}) async {
    final response = await groupRepository.getGroups(useremail: email);

    response.fold(
      (success) {
        _groupModel = success;
        notifyListeners();
      },
      (failure) {
        _groupModel = GroupModel(groups: []);
        print("No group Found: ${_groupModel.groups}");
        notifyListeners();
      },
    );
  }

  Future<void> deleteGroup({required String groupId, context}) async {
    final response = await groupRepository.deleteGroup(groupId: groupId);

    response.fold(
      (success) {
        BaseHelper.showSnackBar(context, "Group deleted", Colors.green);
      },
      (failure) {},
    );
  }

  Future<void> leaveGroup(
      {required String groupId, required String userEmail, context}) async {
    final response = await groupRepository.leaveGroup(
        groupId: groupId, userEmail: userEmail);

    response.fold(
      (success) {
        BaseHelper.showSnackBar(context, "You leave the group", Colors.green);
      },
      (failure) {},
    );
  }
}
