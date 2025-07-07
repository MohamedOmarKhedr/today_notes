// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class NotesCalenderTable extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelectedCallback;

  NotesCalenderTable({
    Key? key,
    required this.selectedDate,
    required this.onDateSelectedCallback,
  }) : super(key: key);

  @override
  State<NotesCalenderTable> createState() => _NotesCalenderTableState();
}

class _NotesCalenderTableState extends State<NotesCalenderTable> {
  // DateTime date = DateTime.now(); // This 'date' variable seems unused.
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    // Ensure firstDay and lastDay calculations do not cause issues if selectedDate is at an extreme.
    // It's safer to base them on DateTime.now() or fixed reasonable points.
    final DateTime firstDay = DateTime.utc(now.year - 2, 1, 1); // Two years back from current year
    final DateTime lastDay = DateTime.utc(now.year + 2, 12, 31); // Two years forward from current year

    return TableCalendar(
      onFormatChanged: (format) {
        setState(() {
          // This local state for calendar format is fine.
          _calendarFormat = format;
        });
      },
      focusedDay: widget.selectedDate,
      firstDay: firstDay,
      lastDay: lastDay,
      calendarFormat: _calendarFormat,
      onDaySelected: (selectedDay, focusedDay) {
        // Call the callback to notify AppCubit
        widget.onDateSelectedCallback(selectedDay);
        // No local setState for selectedDate here, as it's driven by AppCubit.
        // If focusedDay needs immediate update before cubit state changes view:
        // setState(() { _focusedDay = focusedDay; }); // Requires a local _focusedDay variable
      },
      selectedDayPredicate: (day) {
        return isSameDay(widget.selectedDate, day);
      },
      currentDay: now, // Highlight the actual current day
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
    );
  }
}
