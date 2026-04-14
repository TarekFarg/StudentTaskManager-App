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
                  const Icon(Icons.person, size: 80),

                  const SizedBox(height: 20),

                  Text("Name: ${profile!["fullName"]}"),
                  Text("Email: ${profile!["email"]}"),
                  Text("Student ID: ${profile!["studentId"]}"),
                  Text("Gender: ${profile!["gender"]}"),
                  Text("Level: ${profile!["academicLevel"]}"),
                ],
              ),
            ),
    );
  }
}
