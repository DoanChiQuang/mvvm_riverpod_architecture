import 'package:intl/intl.dart';

class Format {
  static String hours(double hours) {
    final hoursNotNegative = hours < 0.0 ? 0.0 : hours;
    final formatter = NumberFormat.decimalPattern();
    final formatted = formatter.format(hoursNotNegative);
    return '${formatted}h';
  }

  static String date(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String dayOfWeek(DateTime date) {
    return DateFormat.E().format(date);
  }

  static String currency(double pay) {
    if (pay != 0.0) {
      final formatter = NumberFormat.simpleCurrency(decimalDigits: 0);
      return formatter.format(pay);
    }
    return '';
  }

  static String timer(
    int seconds, {
    bool hour = false,
    bool minute = false,
  }) {
    final calHours = (seconds / 3600).floor();
    final calMinutes = (seconds % 3600 / 60).floor();
    final calSeconds = seconds % 3600 % 60;

    final hoursToString =
        hour ? '${calHours < 10 ? '0$calHours' : calHours}:' : '';
    final minutesToString =
        minute ? '${calMinutes < 10 ? '0$calMinutes' : calMinutes}:' : '';
    final secondsToString = '${calSeconds < 10 ? '0$calSeconds' : calSeconds}';

    return '$hoursToString$minutesToString$secondsToString';
  }
}
