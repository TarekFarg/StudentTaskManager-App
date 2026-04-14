import 'dart:convert';
import 'package:http/http.dart' as http;

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
}
