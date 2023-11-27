// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class NotesCalenderTable extends StatefulWidget {
  DateTime selectedDate;
  NotesCalenderTable({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<NotesCalenderTable> createState() => _NotesCalenderTableState();
}

class _NotesCalenderTableState extends State<NotesCalenderTable> {
  DateTime date = DateTime.now();

  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onFormatChanged: (format) {
        setState(() {
          if (_calendarFormat == CalendarFormat.month) {
            _calendarFormat = CalendarFormat.week;
          } else {
            _calendarFormat = CalendarFormat.month;
          }
        });
      },
      focusedDay: widget.selectedDate,
      firstDay: DateTime(2023),
      lastDay: DateTime(2024),
      calendarFormat: _calendarFormat,
      onDaySelected: (
        date,
        events,
      ) {
        setState(() {
          widget.selectedDate = date;
        });
      },
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      currentDay: widget.selectedDate,
    );
  }
}
