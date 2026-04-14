import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TaskDetailsScreen extends StatefulWidget {
  final int taskId;
  final int userId;

  const TaskDetailsScreen({
    super.key,
    required this.taskId,
    required this.userId,
  });

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  Map? task;
  bool isLoading = true;
  bool isEditing = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  String priority = "Low";
  DateTime? dueDate;

  @override
  void initState() {
    super.initState();
    loadTask();
  }

  void loadTask() async {
    var data = await ApiService.getTaskById(widget.taskId);

    setState(() {
      task = data;

      titleController.text = data["title"] ?? "";
      descController.text = data["description"] ?? "";
      priority = data["priority"] ?? "Low";
      dueDate = DateTime.parse(data["dueDate"]);

      isLoading = false;
    });
  }

  void updateTask() async {
    await ApiService.editTask(
      widget.taskId,
      titleController.text,
      descController.text,
      dueDate!,
      priority,
      widget.userId,
    );

    setState(() {
      task!["title"] = titleController.text;
      task!["description"] = descController.text;
      task!["priority"] = priority;
      task!["dueDate"] = dueDate.toString();
      isEditing = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Task Updated")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                updateTask();
              } else {
                setState(() => isEditing = true);
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  isEditing
                      ? TextField(controller: titleController)
                      : Text(
                          task!["title"],
                          style: const TextStyle(fontSize: 22),
                        ),

                  const SizedBox(height: 10),

                  // DESCRIPTION
                  isEditing
                      ? TextField(controller: descController)
                      : Text(task!["description"] ?? ""),

                  const SizedBox(height: 20),

                  // PRIORITY
                  isEditing
                      ? DropdownButton<String>(
                          value: priority,
                          items: ["Low", "Medium", "High"]
                              .map(
                                (p) =>
                                    DropdownMenuItem(value: p, child: Text(p)),
                              )
                              .toList(),
                          onChanged: (val) {
                            setState(() => priority = val!);
                          },
                        )
                      : Text("Priority: $priority"),

                  const SizedBox(height: 20),

                  // DUE DATE
                  isEditing
                      ? ElevatedButton(
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                              initialDate: dueDate ?? DateTime.now(),
                            );

                            if (picked != null) {
                              setState(() => dueDate = picked);
                            }
                          },
                          child: const Text("Pick Due Date"),
                        )
                      : Text("Due: ${task!["dueDate"]}"),
                ],
              ),
            ),
    );
  }
}
