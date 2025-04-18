// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:paisay_da_da/data/local/hive.dart';

class GroupSettingScreen extends StatefulWidget {
  List<String>? groupMembers;
  String? createdBy;

  GroupSettingScreen(
      {super.key, required this.groupMembers, required this.createdBy});

  @override
  State<GroupSettingScreen> createState() => _GroupSettingScreenState();
}

class _GroupSettingScreenState extends State<GroupSettingScreen> {
  @override
  Widget build(BuildContext context) {
    var currentUserEmail = HiveDatabase.getValue(HiveDatabase.userKey);
    final isGroupCreator = currentUserEmail == widget.createdBy;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Group Settings",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Created by",
                style: TextStyle(),
              ),
              const SizedBox(height: 12),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.person),
                title: Text(widget.createdBy.toString()),
              ),
              const SizedBox(height: 12),
              const Text(
                "Group Members",
              ),
              const SizedBox(height: 12),
              widget.groupMembers!.isEmpty
                  ? ListTile(
                      onTap: () {},
                      title: const Text("No members found"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.groupMembers?.length ?? 0,
                      itemBuilder: (context, index) {
                        final memberEmail = widget.groupMembers![index];
                        return ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.person),
                          title: Text(memberEmail),
                        );
                      },
                    ),
              const SizedBox(height: 30),
              isGroupCreator
                  ? ListTile(
                      onTap: () {},
                      title: const Text(
                        "Delete Group",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      leading: const Icon(Icons.delete, color: Colors.red),
                    )
                  : SizedBox.shrink(),
              ListTile(
                onTap: () {},
                title: const Text(
                  "Leave Group",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
