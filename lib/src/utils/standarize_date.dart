class StandarizeDate {
  int standarizeDate(int timestamp){
    DateTime dateTimeNow = DateTime.parse("${DateTime.now().year}${(DateTime.now().month< 10)?0:""}${DateTime.now().month}${(DateTime.now().day< 10)?0:""}${DateTime.now().day}");
    if (dateTimeNow.microsecondsSinceEpoch % 86400000000 / 86400000000 == 0.25){
      return timestamp + 3600000000;
    }else {
      return timestamp;
    }
  }

  String getStringDate(DateTime date){
    int day =  date.day;
    int month = date.month;
    int year = date.year;
    switch (month) {
      case 1:
        return '$day ENERO $year';
      case 2:
        return '$day FEBRERO $year';
      case 3:
        return '$day MARZO $year';
      case 4:
        return '$day ABRIL $year';
      case 5:
        return '$day MAYO $year';
      case 6:
        return '$day JUNIO $year';
      case 7:
        return '$day JULIO $year';
      case 8:
        return '$day AGOSTO $year';
      case 9:
        return '$day SEPTIEMBRE $year';
      case 10:
        return '$day OCTUBRE $year';
      case 11:
        return '$day NOVIEMBRE $year';
      case 12:
        return '$day DICIEMBRE $year';
      default:
        return '$day Enero $year';
    }
  }
}