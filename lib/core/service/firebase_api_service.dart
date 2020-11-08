import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:todo_app/core/model/todo.dart';
import 'package:todo_app/core/model/todo_list.dart';

class ApiService {
  String _baseUrl;
  static ApiService _instance = ApiService._init();

  ApiService._init() {
    _baseUrl = "URL_Firebase ";//example: https://flutter-5f9e5.firebaseio.com
  }

  static ApiService getInstance() {
    if (_instance == null) return ApiService._init();
    return _instance;
  }

  //TODO: Buradan getTODO diyerek gerekli olan tüm todo listesini çektik!
  Future<List<Todo>> getTodo() async {
    final response = await http.get("$_baseUrl/todo.json");
    final jsonResponse = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final todoList = TodoList.fromJsonList(jsonResponse);
        return todoList.todoS;
        break;
      default:
        return Future.error(response.body);
    }
  }

  Future<void> addTask(Todo todo) async {
    final taskTodo = json.encode(todo.toJson());
    Logger().i(taskTodo);
    final response = await http.post("$_baseUrl/todo.json", body: taskTodo);

    final jsonResponse = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
        break;
      case HttpStatus.unauthorized:
        print("Error ${response.statusCode}");
        Logger().e(jsonResponse);
        break;
      default:
        return Future.error(response.statusCode);
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  Future<void> deleteTask(String key) async {
    final response = await http.delete("$_baseUrl/todo/$key.json");

    final jsonResponse = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
        break;
      case HttpStatus.unauthorized:
        print("Error ${response.statusCode}");
        Logger().e(jsonResponse);
        break;
      default:
        return Future.error(response.statusCode);
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  Future<void> updateTask(Todo todo, String key) async {
    final response = await http.put(
      "$_baseUrl/todo/$key.json",
      headers: <String, String>{
        'Content-Type': 'todo/json; charset=UTF-8',
      },
      body: json.encode(todo.toJson()),
    );

    final jsonResponse = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
        break;
      case HttpStatus.unauthorized:
        print("Error ${response.statusCode}");
        Logger().e(jsonResponse);
        break;
      default:
        return Future.error(response.statusCode);
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }
}
