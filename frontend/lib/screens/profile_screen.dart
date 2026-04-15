import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  XFile? imageFile;
  Uint8List? imageBytes;

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

  Future<void> pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);

    if (picked != null) {
      final bytes = await picked.readAsBytes();

      setState(() {
        imageFile = picked;
        imageBytes = bytes;
      });
    }
  }

  void updateProfile() async {
    try {
      String? imagePath = profile!["profileImagePath"];

      if (imageFile != null) {
        imagePath = await ApiService.uploadProfileImage(imageFile!);
      }

      await ApiService.updateProfile(
        widget.userId,
        nameController.text,
        gender,
        academicLevel,
        imagePath,
      );

      setState(() {
        profile!["fullName"] = nameController.text;
        profile!["gender"] = gender;
        profile!["academicLevel"] = academicLevel;
        profile!["profileImagePath"] = imagePath;
        isEditing = false;
        imageFile = null;
        imageBytes = null;
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

  ImageProvider? getProfileImage() {
    if (imageBytes != null) {
      return MemoryImage(imageBytes!);
    } else if (profile!["profileImagePath"] != null) {
      return NetworkImage(profile!["profileImagePath"]);
    }
    return null;
  }

  //  LOGOUT FUNCTION
  void logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
                children: [
                  // PROFILE IMAGE
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: getProfileImage(),
                        child: getProfileImage() == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      if (isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.camera),
                                      title: const Text("Camera"),
                                      onTap: () {
                                        Navigator.pop(context);
                                        pickImage(ImageSource.camera);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text("Gallery"),
                                      onTap: () {
                                        Navigator.pop(context);
                                        pickImage(ImageSource.gallery);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // DATA
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
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

                          Row(
                            children: [
                              const Expanded(child: Text("Email")),
                              Expanded(child: Text(profile!["email"])),
                            ],
                          ),
                          const Divider(),

                          Row(
                            children: [
                              const Expanded(child: Text("Student ID")),
                              Expanded(child: Text(profile!["studentId"])),
                            ],
                          ),
                          const Divider(),

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

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (isEditing) {
                              updateProfile();
                            } else {
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
                              setState(() {
                                isEditing = false;
                                imageFile = null;
                                imageBytes = null;
                              });
                            },
                            child: const Text("Cancel"),
                          ),
                        ),
                      ],
                    ],
                  ),

                  //  LOGOUT BUTTON
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: logout,
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
