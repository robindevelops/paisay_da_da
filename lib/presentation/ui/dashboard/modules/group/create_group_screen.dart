import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/base_helper.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/group.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

class CreategroupScreen extends StatefulWidget {
  const CreategroupScreen({super.key});

  @override
  State<CreategroupScreen> createState() => _CreategroupScreenState();
}

class _CreategroupScreenState extends State<CreategroupScreen> {
  TextEditingController groupName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupNotifier>(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Create Group",
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // Group Icon (Funny Placeholder)
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.grey[200],
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
              // const SizedBox(height: 10),

              const SizedBox(height: 30),

              // Group Name Field
              CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
                hintText: "Group name",
                icon: Icons.group,
                controller: groupName,
              ),

              const SizedBox(height: 20),

              AppElevatedButton(
                text: "Create Group",
                onPressed: () async {
                  var value = HiveDatabase.getValue(HiveDatabase.userKey);

                  if (_formKey.currentState!.validate()) {
                    bool success = await groupProvider.CreateGroup(
                      createdBy: value,
                      groupName: groupName.text,
                      members: [],
                      context: context,
                    );
                    if (success) {
                      Navigator.pop(context);
                      groupProvider.getGroups(email: value);
                    }
                  }
                },
              ),

              const SizedBox(height: 20),

              // Another Funny Caption
              // const Text(
              //   "Pro Tip: Doston se udhaar maangna asaan hai,\nwapas lena impossible hai! 😂",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 12, color: Colors.grey),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
