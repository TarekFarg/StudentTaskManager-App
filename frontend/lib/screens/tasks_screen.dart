import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'task_details_screen.dart';
import 'add_task_screen.dart';
import 'profile_screen.dart';
import 'favorite_tasks_screen.dart';
import 'deadline_screen.dart';

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
          // Favorite Tasks Screen
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteTasksScreen(tasks: tasks),
                ),
              );
            },
          ),

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
                    // Mark as Completed Button
                    leading: IconButton(
                      icon: Icon(
                        task["isCompleted"] == true
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: task["isCompleted"] == true
                            ? Colors.green
                            : null,
                      ),
                      onPressed: () {
                        if (task["isCompleted"] != true) {
                          markTaskAsCompleted(task["id"], task);
                        }
                      },
                    ),

                    title: Text(
                      task["title"] ?? "No Title",
                      style: TextStyle(
                        decoration: task["isCompleted"] == true
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task["description"] ?? ""),

                        const SizedBox(height: 4),

                        // 📅 Due Date
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              task["dueDate"] != null
                                  ? task["dueDate"].toString().split("T")[0]
                                  : "No Due Date",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        //  Priority
                        Row(
                          children: [
                            const Icon(
                              Icons.flag,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              task["priority"] ?? "No Priority",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Open Details Only
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
                        IconButton(
                          icon: Icon(
                            task["isFavorite"] == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            toggleFavorite(task);
                          },
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.access_time,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DeadlineScreen(task: task),
                              ),
                            );
                          },
                        ),

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

                        // Status icon
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

  void toggleFavorite(Map task) async {
    final oldValue = task["isFavorite"] == true;

    setState(() {
      task["isFavorite"] = !oldValue;
    });

    try {
      // Call API
      if (oldValue) {
        await ApiService.markTaskAsUnfavorite(task["id"]);
      } else {
        await ApiService.markTaskAsFavorite(task["id"]);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            !oldValue ? "Added to favorites" : "Removed from favorites",
          ),
        ),
      );
    } catch (e) {
      setState(() {
        task["isFavorite"] = oldValue;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  // mark as completed
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
