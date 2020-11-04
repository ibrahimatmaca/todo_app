class DateCalculator {
  String get nowDateParse {
    final _dateTime = DateTime.now();
    String dateTimeDay = _dateTime.day.toString();
    String dateTimeMonth = _dateTime.month.toString();
    String dateTimeYear = _dateTime.year.toString();
    if (int.parse(dateTimeDay) < 10)
      return "0$dateTimeDay/$dateTimeMonth/$dateTimeYear";
    return "$dateTimeDay/$dateTimeMonth/$dateTimeYear";
  }

  String get lastDateParse {
    final _dateTime = DateTime.now();

    String dateTimeDay = _dateTime.day > 1
        ? (_dateTime.day-1).toString()
        : DateTime(_dateTime.year, _dateTime.month + 1, 0).day.toString();

    String dateTimeMonth = _dateTime.month.toString();
    String dateTimeYear = _dateTime.year.toString();

    if (int.parse(dateTimeDay) < 10)
      return "0$dateTimeDay/$dateTimeMonth/$dateTimeYear";
    return "$dateTimeDay/$dateTimeMonth/$dateTimeYear";
  }

  String selectedDateParse(DateTime dateTime) {
    String dateTimeDay = dateTime.day.toString();
    String dateTimeMonth = dateTime.month.toString();
    String dateTimeYear = dateTime.year.toString();
    if (int.parse(dateTimeDay) < 10)
      return "0$dateTimeDay/$dateTimeMonth/$dateTimeYear";
    return "$dateTimeDay/$dateTimeMonth/$dateTimeYear";
  }
}
