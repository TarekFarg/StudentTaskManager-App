import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TasksScreen extends StatefulWidget {
  final int userId;

  const TasksScreen({super.key, required this.userId});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    try {
      setState(() {
        isLoading = true;
      });

      var data = await ApiService.getTasks(widget.userId);

      setState(() {
        tasks = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error loading tasks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks"), centerTitle: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
          ? const Center(
              child: Text("No Tasks Yet", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                var task = tasks[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.task_alt),
                    title: Text(task["title"] ?? "No Title"),
                    subtitle: Text(task["description"] ?? ""),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            ),
    );
  }
}
