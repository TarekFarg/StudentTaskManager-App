import 'package:flutter/material.dart';

class FavoriteTasksScreen extends StatelessWidget {
  final List tasks;

  const FavoriteTasksScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    // Filter favorite tasks
    List favoriteTasks = tasks
        .where((task) => task["isFavorite"] == true)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Tasks"), centerTitle: true),
      body: favoriteTasks.isEmpty
          ? const Center(
              child: Text("No Favorite Tasks", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              itemCount: favoriteTasks.length,
              itemBuilder: (context, index) {
                var task = favoriteTasks[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(task["title"] ?? "No Title"),
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

                        // Priority
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
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        task["isFavorite"] = false;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
