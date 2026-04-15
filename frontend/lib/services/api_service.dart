import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ApiService {
  static const String baseUrl = "http://localhost:5247/api";

  // login service
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Student/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  // get user tasks
  static Future<List<dynamic>> getTasks(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tasks/student/$userId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load tasks");
    }
  }

  // delete task
  static Future deleteTask(int taskId) async {
    final response = await http.delete(Uri.parse("$baseUrl/Tasks/$taskId"));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete task");
    }
  }

  // Mark as completed
  static Future markTaskAsCompleted(int id) async {
    final response = await http.put(
      Uri.parse("$baseUrl/Tasks/MarkAsCompleted/$id"),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to mark task as completed");
    }
  }

  // get Task by id
  static Future getTaskById(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/Tasks/$id"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load task");
    }
  }

  // edit task
  static Future editTask(
    int id,
    String title,
    String description,
    DateTime dueDate,
    String priority,
    int userId,
  ) async {
    final response = await http.put(
      Uri.parse("$baseUrl/Tasks/Edit/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "description": description,
        "dueDate": dueDate.toIso8601String(),
        "priority": priority,
        "userId": userId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update task");
    }
  }

  // add task
  static Future addTask(
    String title,
    String description,
    DateTime dueDate,
    String priority,
    int userId,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/Tasks"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "description": description,
        "dueDate": dueDate.toIso8601String(),
        "priority": priority,
        "userId": userId,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to add task");
    }
  }

  // Signup
  static Future signup(
    String fullName,
    String gender,
    String email,
    String studentId,
    int academicLevel,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/Student/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "fullName": fullName,
        "gender": gender,
        "email": email,
        "studentId": studentId,
        "academicLevel": academicLevel,
        "password": password,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
  }

  // get profile
  static Future getProfile(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/Profile/$id"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load profile");
    }
  }

  // edit profile
  static Future updateProfile(
    int id,
    String fullName,
    String gender,
    int academicLevel,
    String? imagePath,
  ) async {
    final response = await http.put(
      Uri.parse("$baseUrl/Profile/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "fullName": fullName,
        "gender": gender,
        "academicLevel": academicLevel,
        "profileImagePath": imagePath,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update profile");
    }
  }

  // upload profile image
  static Future<String> uploadProfileImage(XFile image) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/Profile/upload-profile-image"),
    );

    var bytes = await image.readAsBytes();

    request.files.add(
      http.MultipartFile.fromBytes("file", bytes, filename: image.name),
    );

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var data = jsonDecode(responseBody);
      return data["path"];
    } else {
      throw Exception("Image upload failed");
    }
  }
}
