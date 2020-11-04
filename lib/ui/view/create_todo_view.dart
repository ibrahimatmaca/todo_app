import 'package:flutter/material.dart';

import '../../core/date/date_calculator.dart';
import '../../core/model/todo.dart';
import '../../core/service/firebase_api_service.dart';
import '../shared/decoration/text_form_field_decoration.dart';
import '../shared/styles/text_styles.dart';

class CreateTodoView extends StatefulWidget {
  CreateTodoView({Key key}) : super(key: key);

  @override
  _CreateTodoViewState createState() => _CreateTodoViewState();
}

class _CreateTodoViewState extends State<CreateTodoView> {
  final _formKey = GlobalKey<FormState>();

  DateCalculator dateProcess = DateCalculator();
  DateTime dateTime;

  TextEditingController textEditTitle = TextEditingController();
  TextEditingController textEditDate = TextEditingController();
  TextEditingController textEditDetail = TextEditingController();

  void addTextEditDate() {
    textEditDate.text = dateTime != null
        ? dateProcess.selectedDateParse(dateTime)
        : dateProcess.nowDateParse;
  }

  @override
  Widget build(BuildContext context) {
    addTextEditDate();
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Create Task",
              style: titleStyle,
            ),
            formTextEdit,
            SizedBox(
              height: 20,
            ),
            buildRaisedButtonSend,
          ],
        ),
      ),
    );
  }

  Widget get formTextEdit {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 0.0, 0.0),
            child: TextFormField(
              controller: textEditTitle,
              style: detailPageStyle,
              maxLines: 1,
              cursorColor: Colors.white,
              decoration: decorationTitle(title: "Title here"),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Title is empty';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 0.0, 0.0),
            child: dateTimeSelectedRow(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 0.0, 0.0),
            child: TextFormField(
              controller: textEditDetail,
              style: detailPageStyle,
              maxLines: 11,
              cursorColor: Colors.white,
              decoration: decorationDetail(detail: "Detail here"),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Detail is empty';
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }

  Row dateTimeSelectedRow() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 3,
          child: TextFormField(
            controller: textEditDate,
            readOnly: true,
            style: detailPageStyle,
            maxLines: 1,
            cursorColor: Colors.white,
            keyboardType: TextInputType.datetime,
            decoration: decorationDate(dateProcess.nowDateParse),
          ),
        ),
        Flexible(
            flex: 1,
            child: RaisedButton.icon(
              color: Colors.transparent,
              icon: Icon(
                Icons.arrow_circle_down_outlined,
                color: Colors.white,
                size: 45,
              ),
              label: Text(""),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: dateTime == null ? DateTime.now() : dateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                ).then((date) {
                  setState(() {
                    dateTime = date;
                  });
                });
              },
            ))
      ],
    );
  }

  RaisedButton get buildRaisedButtonSend {
    return RaisedButton.icon(
      icon: Icon(
        Icons.send,
        size: 55,
        color: Colors.blueAccent,
      ),
      label: Text(""),
      color: Colors.transparent,
      splashColor: Colors.green,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          var modelTodo = Todo(
              title: textEditTitle.text,
              date: textEditDate.text.isEmpty
                  ? dateProcess.nowDateParse
                  : textEditDate.text,
              detail: textEditDetail.text,
              completed: false);
          await ApiService.getInstance().addTask(modelTodo);
          Navigator.pop(context);
        }
      },
    );
  }
}
