import 'package:todo_app/core/model/todo.dart';

class DateSort {
  List<Todo> selectedNowDate({List<Todo> data, String selectedDate}) {
    List<Todo> _selectedDateTodos = [];

    for (var item in data) {
      if (item.date == selectedDate) _selectedDateTodos.add(item);
    }
    return _selectedDateTodos;
  }

  List<Todo> lastDayRemove({List<Todo> data, String lastDay}){
    List<Todo> _selectedDateTodos = [];

    for (var item in data) {
      if (item.date == lastDay) _selectedDateTodos.add(item);
    }
    return _selectedDateTodos;
  }
}
