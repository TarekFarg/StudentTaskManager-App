import 'package:flutter/material.dart';

class DeadlineScreen extends StatelessWidget {
  final Map task;

  const DeadlineScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    DateTime dueDate = DateTime.parse(task["dueDate"]);

    Duration remaining = dueDate.difference(now);

    return Scaffold(
      appBar: AppBar(title: const Text("Deadline Reminder"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Task: ${task["title"]}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text("Due Date: $dueDate"),

            const SizedBox(height: 10),

            Text("Today: $now"),

            const SizedBox(height: 20),

            Text(
              "Remaining: ${remaining.inDays} days",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
