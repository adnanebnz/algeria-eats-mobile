import 'package:intl/intl.dart';

class DateFormattter {
  static String getFormattedDate(String date) {
    return DateFormat.yMMMd().format(DateTime.parse(date));
  }
}
