import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/domain/models/groupmodel/group.model.dart';
import 'package:paisay_da_da/domain/repository/group.repository.dart';
import 'package:paisay_da_da/presentation/notifier/loader.notifier.dart';
import 'package:provider/provider.dart';

class GroupNotifier extends ChangeNotifier {
  GroupRepository groupRepository;

  GroupModel _groupModel = GroupModel(groups: []);

  GroupModel get groupModel => _groupModel;

  GroupNotifier({required this.groupRepository});

  Future<bool> CreateGroup({
    required String createdBy,
    required String groupName,
    required List<String> members,
    required BuildContext context,
  }) async {
    LoaderNotifier loaderNotifier = Provider.of<LoaderNotifier>(
      context,
      listen: false,
    );

    loaderNotifier.setLoading(true);
    notifyListeners();

    // await Future.delayed(Duration(seconds: 2));

    var response = await groupRepository.createGroup(
      groupName: groupName,
      members: members,
      createdBy: createdBy,
    );

    var result = response.fold(
      (success) {
        // BaseHelper.showSnackBar(
        //   context,
        //   success.message.toString(),
        //   Colors.green,
        // );
        return true;
      },
      (failure) {
        BaseHelper.showSnackBar(
          context,
          failure.message.toString(),
          Colors.red,
        );

        return false;
      },
    );
    loaderNotifier.setLoading(false);
    notifyListeners();
    return result;
  }

  Future<void> getGroups({
    required String email,
    String? groupId,
  }) async {
    final response = await groupRepository.getGroups(
      useremail: email,
      groupId: groupId,
    );

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

  Future<void> deleteGroup({
    required String groupId,
    required BuildContext context,
  }) async {
    final response = await groupRepository.deleteGroup(groupId: groupId);

    response.fold(
      (success) {
        // BaseHelper.showSnackBar(context, "Group deleted", Colors.green);
      },
      (failure) {},
    );
  }

  Future<void> leaveGroup({
    required String groupId,
    required String userEmail,
    required BuildContext context,
  }) async {
    final response = await groupRepository.leaveGroup(
        groupId: groupId, userEmail: userEmail);

    response.fold(
      (success) {
        BaseHelper.showSnackBar(context, "You leave the group", Colors.green);
      },
      (failure) {},
    );
  }

  Future<void> addMember({
    required String groupId,
    required List<String> email,
    required BuildContext context,
  }) async {
    final response = await groupRepository.addMember(
      groupId: groupId,
      members: email,
    );

    response.fold(
      (success) {
        BaseHelper.showSnackBar(
          context,
          success.message.toString(),
          Colors.green,
        );
      },
      (failure) {
        BaseHelper.showSnackBar(
          context,
          failure.message.toString(),
          Colors.red,
        );
      },
    );
  }
}
