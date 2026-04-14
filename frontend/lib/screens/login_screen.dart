import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'tasks_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  var result = await ApiService.login(
                    emailController.text,
                    passwordController.text,
                  );

                  // go to Tasks Screen for this user
                  int userId = result["id"];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TasksScreen(userId: userId),
                    ),
                  );

                  print(result);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Login Success")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
