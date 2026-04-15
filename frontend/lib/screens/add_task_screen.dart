import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddTaskScreen extends StatefulWidget {
  final int userId;

  const AddTaskScreen({super.key, required this.userId});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  String priority = "Low";
  DateTime? dueDate;

  void addTask() async {
    if (titleController.text.isEmpty) return;

    await ApiService.addTask(
      titleController.text,
      descController.text,
      dueDate ?? DateTime.now(),
      priority,
      widget.userId,
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TITLE
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            const SizedBox(height: 10),

            // DESCRIPTION
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"),
            ),

            const SizedBox(height: 20),

            // PRIORITY
            DropdownButton<String>(
              value: priority,
              isExpanded: true,
              items: [
                "Low",
                "Medium",
                "High",
              ].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (val) {
                setState(() => priority = val!);
              },
            ),

            const SizedBox(height: 20),

            // DATE
            ElevatedButton(
              onPressed: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  initialDate: DateTime.now(),
                );

                if (picked != null) {
                  setState(() => dueDate = picked);
                }
              },
              child: const Text("Pick Due Date"),
            ),

            const SizedBox(height: 30),

            // SAVE BUTTON
            ElevatedButton(onPressed: addTask, child: const Text("Add Task")),
          ],
        ),
      ),
    );
  }
}
