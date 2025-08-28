// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/selection.notifier.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

class AddMembersScreen extends StatefulWidget {
  const AddMembersScreen({super.key});

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final friendNotifier = context.watch<FriendNotifier>();
    final selectionNotifier = context.watch<SelectionNotifier>();
    final isSelected = selectionNotifier.members.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add Members",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          TextButton(
            onPressed: isSelected
                ? () {
                    Navigator.pop(context);
                  }
                : null,
            child: Text(
              "Save",
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            CustomTextField(
              hintText: 'Search member',
              icon: Icons.search,
              controller: _searchController,
            ),
            const SizedBox(height: 20),
            Text(
              "Friends",
              style: GoogleFonts.aBeeZee(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            (friendNotifier.acceptedModel.data == null ||
                    friendNotifier.acceptedModel.data!.isEmpty)
                ? const ListTile(
                    title: Text("No Member Found"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: friendNotifier.acceptedModel.data?.length,
                    itemBuilder: (context, index) {
                      final friend = friendNotifier.acceptedModel.data![index];
                      return MemberTile(
                        name: friend.friend!.firstName ?? "unknown",
                        email: friend.friend!.email ?? "unknown",
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  final String name;
  final String email;

  const MemberTile({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final selectionNotifier = context.watch<SelectionNotifier>();
    final isSelected = selectionNotifier.members.contains(email);

    return ListTile(
      leading: const Icon(Icons.person_3_outlined),
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      trailing: Checkbox(
        checkColor: Colors.black,
        activeColor: AppThemes.highlightGreen,
        value: isSelected,
        onChanged: (value) {
          if (value == true) {
            selectionNotifier.addMember(email);
          } else {
            selectionNotifier.removeMember(email);
          }
        },
      ),
      title: Text(name.capitalizeFirst()),
    );
  }
}

extension StringCasingExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
