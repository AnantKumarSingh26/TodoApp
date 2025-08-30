import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<void> saveTodos(List<Todo> todos) async {
  final prefs = await SharedPreferences.getInstance();
  final todosJson = jsonEncode(todos.map((t) => t.toJson()).toList());
  await prefs.setString('todos', todosJson);
}
Future<List<Todo>> loadTodos() async {
  final prefs = await SharedPreferences.getInstance();
  final todosJson = prefs.getString('todos');
  if (todosJson == null) return [];
  final List<dynamic> decoded = jsonDecode(todosJson);
  return decoded.map((item) => Todo.fromJson(item)).toList();
}
class Todo {
  String title;
  bool completed;

  Todo({required this.title, required this.completed});

  Map<String, dynamic> toJson() => {
    'title': title,
    'completed': completed,
  };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    title: json['title'],
    completed: json['completed'],
  );
}