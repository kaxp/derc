import 'package:intl/intl.dart';

class DateFormatter {
  static String formattedFullDateAndTimeWithComma(DateTime dateTime) {
    var format = 'EEEE, dd MMM yyyy, hh:mm a';
    var dateFormatter = DateFormat(format, 'en');
    return dateFormatter.format(dateTime);
  }
}
