import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'task_details_screen.dart';
import 'add_task_screen.dart';
import 'profile_screen.dart';

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
      appBar: AppBar(
        title: const Text("My Tasks"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(userId: widget.userId),
                ),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(userId: widget.userId),
                ),
              );

              if (result == true) {
                loadTasks();
              }
            },
          ),
        ],
      ),
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
                    // Mark as Completed
                    leading: Icon(
                      task["isCompleted"] == true
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: task["isCompleted"] == true ? Colors.green : null,
                    ),

                    title: Text(
                      task["title"] ?? "No Title",
                      style: TextStyle(
                        decoration: task["isCompleted"] == true
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),

                    subtitle: Text(task["description"] ?? ""),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailsScreen(
                            taskId: task["id"],
                            userId: widget.userId,
                          ),
                        ),
                      );
                    },

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Delete button
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Delete Task"),
                                content: const Text(
                                  "Are you sure you want to delete this task?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      deleteTask(task["id"]);
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        // status icon
                        task["isCompleted"] == true
                            ? const Icon(Icons.done, color: Colors.green)
                            : const Icon(Icons.touch_app),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  // delete task
  void deleteTask(int taskId) async {
    try {
      await ApiService.deleteTask(taskId);

      setState(() {
        tasks.removeWhere((task) => task["id"] == taskId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task deleted successfully")),
      );
    } catch (e) {
      print("Delete error: $e");
    }
  }

  // Mark as completed
  void markTaskAsCompleted(int taskId, Map task) async {
    try {
      await ApiService.markTaskAsCompleted(taskId);

      setState(() {
        task["isCompleted"] = true;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Task marked as completed")));
    } catch (e) {
      print("Error: $e");
    }
  }
}
