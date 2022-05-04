import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDate {
  static DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  static DateFormat dayDateFormat = DateFormat("dd/MM/yyyy");
  static DateFormat timeFormat = DateFormat("HH'h'mm");
  static DateFormat dateTimeFormat = DateFormat("dd/MM/yyyy HH:mm");
  static DateFormat dayDateTimeFormat = DateFormat("dd/MM/yyyy à HH'h'mm");

  static DateFormat dayDateTimeFormatString =
      DateFormat("EEEE dd/MM/yyyy à HH'h' mm", 'fr');
  static DateFormat dayDateFormatString = DateFormat("EEEE dd/MM/yyyy", 'fr');

  static DateFormat dateFormatNameDayMonth = DateFormat("E dd/MM", 'fr');
  static DateTime? dateTimeFromTime(TimeOfDay? time) {
    if (time == null) return null;
    return DateTime(2022, 1, 1, time.hour, time.minute);
  }

  static String? displayTime(TimeOfDay? time) {
    if (time == null) return null;
    DateTime date = DateTime(2022, 1, 1, time.hour, time.minute);
    return DateFormat("HH'h' mm").format(date);
  }
}