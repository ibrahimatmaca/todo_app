import 'package:flutter/material.dart';
import '../../core/model/todo.dart';
import '../../core/service/firebase_api_service.dart';
import '../shared/decoration/text_form_field_decoration.dart';
import '../shared/styles/text_styles.dart';

class DetailAndUpdateView extends StatefulWidget {
  final Todo currentTodo;
  DetailAndUpdateView({Key key, this.currentTodo}) : super(key: key);

  @override
  _DetailAndUpdateViewState createState() => _DetailAndUpdateViewState();
}

class _DetailAndUpdateViewState extends State<DetailAndUpdateView> {
  GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKey");

  TextEditingController textEditTitle = TextEditingController();
  TextEditingController textEditDetail = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditTitle.text = widget.currentTodo.title;
    textEditDetail.text = widget.currentTodo.detail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Edit Task",
                style: titleStyle,
              ),
              SizedBox(height: 10),
              buildRowSendButton,
              SizedBox(height: 30),
              _titleTextFormField,
              SizedBox(height: 10),
              _detailTextFormField,
            ],
          ),
        ),
      ),
    );
  }

  Container get buildRowSendButton {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            splashColor: Colors.blueAccent,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.edit,
                  size: 30,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Edit",
                  style: detailPageStyle,
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            onTap: () async {
              widget.currentTodo.title = textEditTitle.text.isNotEmpty
                  ? textEditTitle.text
                  : widget.currentTodo.title;
              widget.currentTodo.detail = textEditDetail.text.isNotEmpty
                  ? textEditDetail.text
                  : widget.currentTodo.detail;
              await ApiService.getInstance()
                  .updateTask(widget.currentTodo, widget.currentTodo.key);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget get _titleTextFormField {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0.0, 0.0, 0.0),
      child: new TextFormField(
        controller: textEditTitle,
        style: detailPageStyle,
        maxLines: 1,
        cursorColor: Colors.white,
        decoration: decorationTitle(),
        validator: (value) => value.isEmpty ? 'Title can\'t be empty' : null,
      ),
    );
  }

  Widget get _detailTextFormField {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0.0, 0.0, 0.0),
      child: new TextFormField(
        controller: textEditDetail,
        style: detailPageStyle,
        maxLines: 15,
        cursorColor: Colors.white,
        decoration: decorationDetail(),
        validator: (value) => value.isEmpty ? 'Detail can\'t be empty' : null,
      ),
    );
  }
}
