import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String gender = "Male";
  int academicLevel = 1;

  bool isLoading = false;

  void signup() async {
    //  validate form first
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await ApiService.signup(
        fullNameController.text,
        gender,
        emailController.text,
        studentIdController.text,
        academicLevel,
        passwordController.text,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Signup successful")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// Full Name
              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Full name is required";
                  }
                  return null;
                },
              ),

              /// Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),

              /// Student ID
              TextFormField(
                controller: studentIdController,
                decoration: const InputDecoration(labelText: "Student ID"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Student ID is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              /// Gender
              DropdownButtonFormField<String>(
                initialValue: gender,
                decoration: const InputDecoration(labelText: "Gender"),
                items: ["Male", "Female"]
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) {
                  setState(() => gender = val!);
                },
              ),

              const SizedBox(height: 10),

              /// Academic Level
              DropdownButtonFormField<int>(
                initialValue: academicLevel,
                decoration: const InputDecoration(labelText: "Academic Level"),
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
              ),

              const SizedBox(height: 10),

              /// Password
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 8) {
                    return "At least 8 characters required";
                  }
                  if (!RegExp(r'\d').hasMatch(value)) {
                    return "Must contain at least one number";
                  }
                  return null;
                },
              ),

              /// Confirm Password
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm your password";
                  }
                  if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: signup,
                      child: const Text("Sign Up"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
