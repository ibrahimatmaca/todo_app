class Todo {
  String date;
  String title;
  String detail;
  bool completed;
  String key;

  Todo({
    this.date,
    this.title,
    this.detail,
    this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        date: json["date"],
        title: json["title"],
        detail: json["detail"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "title": title,
        "detail": detail,
        "completed": completed,
      };
}
