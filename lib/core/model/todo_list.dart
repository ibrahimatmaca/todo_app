import 'package:todo_app/core/model/todo.dart';

class TodoList {
  List<Todo> todoS = [];

  TodoList.fromJsonList(value) {
    value.forEach((key, value) {
      var todo = Todo.fromJson(value);
      todo.key = key;
      todoS.add(todo);
    });
  }
}
