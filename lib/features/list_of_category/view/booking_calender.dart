import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendar extends StatefulWidget {
  const BookingCalendar({Key? key}) : super(key: key);

  @override
  _BookingCalendarState createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  late CalendarFormat _calendarFormat;
  DateTime? _selectedDate;
  DateTime? _focusedDate;
  Map<DateTime, List<dynamic>> _events = {};

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _selectedDate = DateTime.now();
    _focusedDate = _selectedDate;
  }

  void _onDaySelected(DateTime? selectedDate, DateTime? focusedDate) {
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        _focusedDate = focusedDate;
      });
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime? focusedStart, DateTime? focusedEnd) {
    if (start != null && end != null) {
      final selectedDays = [
        for (var d = start; d.isBefore(end); d = d.add(const Duration(days: 1)))
          DateTime(d.year, d.month, d.day),
      ];

      setState(() {
        for (final day in selectedDays) {
          _events[day] = (_events.containsKey(day) ? null : ['Selected'])!;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            rangeStartDay: _focusedDate,
            rangeEndDay: _focusedDate,
            focusedDay: _focusedDate!,
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            eventLoader: (day) => _events[day] ?? [],
            onDaySelected: _onDaySelected,
            // onRangeSelected: _onRangeSelected,
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, _) => Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${date.day}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              rangeStartBuilder: (context, date, _) => Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${date.day}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              rangeEndBuilder: (context, date, _) => Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${date.day}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print('Selected Days:');
              for (final entry in _events.entries) {
                if (entry.value != null) {
                  print(entry.key);
                }
              }
            },
            child: const Text('Print Selected Days'),
          ),
        ],
      ),
    );
  }
}