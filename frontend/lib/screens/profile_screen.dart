import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map? profile;
  bool isLoading = true;

  bool isEditing = false;

  TextEditingController nameController = TextEditingController();
  String gender = "Male";
  int academicLevel = 1;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    var data = await ApiService.getProfile(widget.userId);

    setState(() {
      profile = data;
      isLoading = false;
    });
  }

  void updateProfile() async {
    try {
      await ApiService.updateProfile(
        widget.userId,
        nameController.text,
        gender,
        academicLevel,
      );

      setState(() {
        profile!["fullName"] = nameController.text;
        profile!["gender"] = gender;
        profile!["academicLevel"] = academicLevel;
        isEditing = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Profile updated")));
    } catch (e) {
      String errorMessage = e.toString().replaceAll("Exception: ", "");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Icon(Icons.person, size: 80)),

                  const SizedBox(height: 20),

                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // NAME
                          Row(
                            children: [
                              const Expanded(child: Text("Name")),
                              Expanded(
                                child: isEditing
                                    ? TextField(controller: nameController)
                                    : Text(profile!["fullName"]),
                              ),
                            ],
                          ),

                          const Divider(),

                          // EMAIL
                          Row(
                            children: [
                              const Expanded(child: Text("Email")),
                              Expanded(child: Text(profile!["email"])),
                            ],
                          ),

                          const Divider(),

                          // STUDENT ID
                          Row(
                            children: [
                              const Expanded(child: Text("Student ID")),
                              Expanded(child: Text(profile!["studentId"])),
                            ],
                          ),

                          const Divider(),

                          // GENDER
                          Row(
                            children: [
                              const Expanded(child: Text("Gender")),
                              Expanded(
                                child: isEditing
                                    ? DropdownButton<String>(
                                        value: gender,
                                        isExpanded: true,
                                        items: ["Male", "Female"]
                                            .map(
                                              (g) => DropdownMenuItem(
                                                value: g,
                                                child: Text(g),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (val) {
                                          setState(() => gender = val!);
                                        },
                                      )
                                    : Text(profile!["gender"]),
                              ),
                            ],
                          ),

                          const Divider(),

                          // LEVEL
                          Row(
                            children: [
                              const Expanded(child: Text("Level")),
                              Expanded(
                                child: isEditing
                                    ? DropdownButton<int>(
                                        value: academicLevel,
                                        isExpanded: true,
                                        items: [1, 2, 3, 4]
                                            .map(
                                              (lvl) => DropdownMenuItem(
                                                value: lvl,
                                                child: Text("Level $lvl"),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (val) {
                                          setState(() => academicLevel = val!);
                                        },
                                      )
                                    : Text("${profile!["academicLevel"]}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (isEditing) {
                              updateProfile();
                            } else {
                              // تحميل القيم القديمة
                              nameController.text = profile!["fullName"];
                              gender = profile!["gender"];
                              academicLevel = profile!["academicLevel"];

                              setState(() => isEditing = true);
                            }
                          },
                          child: Text(isEditing ? "Save" : "Edit Profile"),
                        ),
                      ),

                      if (isEditing) ...[
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() => isEditing = false);
                            },
                            child: const Text("Cancel"),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
