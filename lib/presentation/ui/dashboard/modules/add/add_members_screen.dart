// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMembersScreen extends StatefulWidget {
  const AddMembersScreen({super.key});

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy friend list
  List<Map<String, String>> allFriends = [
    {"name": "Ali Khan", "email": "ali@example.com"},
    {"name": "Sara Ahmed", "email": "sara@example.com"},
    {"name": "John Doe", "email": "john@example.com"},
  ];

  List<Map<String, String>> filteredFriends = [];

  @override
  void initState() {
    super.initState();
    filteredFriends = allFriends;
  }

  void filterFriends(String query) {
    setState(() {
      filteredFriends = allFriends
          .where((friend) =>
              friend["name"]!.toLowerCase().contains(query.toLowerCase()) ||
              friend["email"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 17),
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
            TextField(
              controller: _searchController,
              onChanged: filterFriends,
              decoration: InputDecoration(
                hintText: "Search members",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
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
            filteredFriends.isEmpty
                ? const ListTile(
                    title: Text("No Member Found"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredFriends.length,
                    itemBuilder: (context, index) {
                      var friend = filteredFriends[index];
                      return MemberTile(
                        name: friend["name"]!,
                        email: friend["email"]!,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class MemberTile extends StatefulWidget {
  final String name;
  final String email;

  const MemberTile({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person_3_outlined),
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      trailing: Checkbox(
        checkColor: Colors.black,
        activeColor: Colors.green,
        value: isSelected,
        onChanged: (value) {
          setState(() {
            isSelected = value ?? false;
          });
        },
      ),
      title: Text(widget.name.capitalizeFirst()),
      subtitle: Text(widget.email),
    );
  }
}

extension StringCasingExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
