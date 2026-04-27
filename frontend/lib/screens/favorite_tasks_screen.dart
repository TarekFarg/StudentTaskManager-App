import 'package:flutter/material.dart';

class FavoriteTasksScreen extends StatelessWidget {
  final List tasks;

  const FavoriteTasksScreen({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    // Filter favorite tasks
    List favoriteTasks =
        tasks.where((task) => task["isFavorite"] == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Tasks"),
        centerTitle: true,
      ),
      body: favoriteTasks.isEmpty
          ? const Center(
              child: Text(
                "No Favorite Tasks",
                style: TextStyle(fontSize: 18),
              ),
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
                    subtitle: Text(
                      task["description"] ?? "",
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
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