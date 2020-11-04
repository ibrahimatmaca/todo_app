import 'package:flutter/material.dart';
import 'package:todo_app/ui/view/detail_and_update_view.dart';
import 'ui/view/create_todo_view.dart';
import 'ui/view/home_view.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO',
      initialRoute: "/",
      routes: {
        "/": (context) => HomeView(),
        "/detailandupdate": (context) => DetailAndUpdateView(),
        "/craetetodo": (context) => CreateTodoView()
      },
    );
  }
}
