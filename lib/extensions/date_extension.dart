import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String format() {
    return DateFormat('d MMM\nHH:mm', 'ru_RU').format(this);
  }
}
