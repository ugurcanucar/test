import 'package:flutter/material.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:table_calendar/table_calendar.dart';

class WidgetCalendar extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final Function(DateTime selectedDay, DateTime focusedDay)? onDaySelected;
  final Function(DateTime selectedDay)? onPageChanged;

  const WidgetCalendar({
    Key? key,
    required this.onDaySelected,
    required this.selectedDay,
    required this.focusedDay,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: Langauge.locale.toString(),
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: focusedDay,
      headerVisible: true,
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
      ),
      calendarFormat: CalendarFormat.week,
      calendarStyle: CalendarStyle(
        markerDecoration: BoxDecoration(color: UIColor.azureRadiance),
        todayDecoration: BoxDecoration(color: UIColor.white),
        todayTextStyle: TextStyle(color: UIColor.azureRadiance),
        selectedDecoration:
            BoxDecoration(color: UIColor.azureRadiance, shape: BoxShape.circle),
        selectedTextStyle: TextStyle(color: UIColor.white),
        defaultTextStyle: TextStyle(color: UIColor.black),
      ),
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(selectedDay, day);
      },
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
    );
  }
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
