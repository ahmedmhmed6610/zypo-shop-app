import 'package:intl/intl.dart';

class CustomGermanyFormatter {
  static String germanyNumberFormat(double num) =>
      NumberFormat.currency(locale: 'de', symbol: '€').format(num);
  static String germanyDateFormat(dynamic date) => date is String
      ? DateFormat.yMd('de').format(DateTime.parse(date))
      : DateFormat.yMd('de').format(date);
  static String germanyTimeFormat(String time) =>
      DateFormat.Hm('de').format(DateTime.parse('2021-12-13 ' + time));
}
