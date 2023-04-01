int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return to.difference(from).inDays;
}

int ageDay(String YYYYMMDD) {
  // YYYYMMDD is a string in the format of "YYYYMMDD"
  // the birthday's date
  final birthday = DateTime(int.parse(YYYYMMDD.substring(0, 4)), int.parse(YYYYMMDD.substring(4, 6)), int.parse(YYYYMMDD.substring(6, 8)));
  final date2 = DateTime.now();
  final difference = daysBetween(birthday, date2);
  return difference;
}

String ageParse(String YYYYMMDDwithDash) {
  return YYYYMMDDwithDash.replaceAll('-', '');
}

int ageYear(String YYYYMMDD) {
  return (ageDay(YYYYMMDD)/365).round();
}
