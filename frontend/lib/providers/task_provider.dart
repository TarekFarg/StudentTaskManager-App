import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Task> get favoriteTasks =>
      _tasks.where((t) => t.isFavorite).toList();

  void setTasks(List<Task> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void toggleFavorite(Task task) {
    task.isFavorite = !task.isFavorite;
    notifyListeners();
  }

  void toggleCompleted(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }
}