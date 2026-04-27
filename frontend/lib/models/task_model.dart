class Task {
  int? id;
  String title;
  String description;
  DateTime dueDate;
  String priority;

  bool isCompleted;
  bool isFavorite;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
    this.isFavorite = false,
  });
}