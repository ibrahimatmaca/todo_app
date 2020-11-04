import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo_app/core/model/todo.dart';
import 'package:todo_app/core/service/firebase_api_service.dart';
import 'package:todo_app/ui/shared/styles/icon_styles.dart';
import 'package:todo_app/ui/shared/styles/text_styles.dart';
import 'package:todo_app/ui/view/detail_and_update_view.dart';

// ignore: must_be_immutable
class CustomCard extends StatefulWidget {
  final Todo receiveTodo;
  var completedTask;

  CustomCard({Key key, this.receiveTodo, this.completedTask}) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: ListTile(
          title: Text(
            widget.receiveTodo.title,
            style:
                widget.completedTask == false ? cardTitleStyle : doneTextStyle,
            maxLines: 1,
          ),
          trailing: buildIconButton,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return DetailAndUpdateView(currentTodo: widget.receiveTodo);
              }),
            );
          },
        ),
      ),
    );
  }

  Widget get buildIconButton {
    return RaisedButton.icon(
      label: Text(""),
      color: Colors.white,
      elevation: 0,
      splashColor: Colors.white,
      icon:
          widget.completedTask == false ? trailingEmptyIcon : trailingDoneIcon,
      onPressed: () async {
        widget.receiveTodo.completed = !widget.completedTask;
        await ApiService.getInstance()
            .updateTask(widget.receiveTodo, widget.receiveTodo.key);
        setState(() {
          widget.completedTask = !widget.completedTask;
        });
      },
    );
  }
}
