import 'package:flutter/material.dart';
import 'package:todo_app/ui/shared/styles/text_styles.dart';

InputDecoration decorationTitle({String title}) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent, width: 4.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white38, width: 3.0),
    ),
    labelStyle: detailPageStyle,
    hintText: title,
    hintStyle: detailPageStyle,
    border: OutlineInputBorder(),
  );
}

InputDecoration decorationDate(String deco) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent, width: 4.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white38, width: 3.0),
    ),
    labelStyle: detailPageStyle,
    hintText: deco,
    hintStyle: detailPageStyle,
    border: OutlineInputBorder(),
  );
}

InputDecoration decorationDetail({String detail}) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent, width: 4.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white38, width: 3.0),
    ),
    labelStyle: detailPageStyle,
    hintText: detail,
    hintStyle: detailPageStyle,
    border: OutlineInputBorder(),
  );
}
