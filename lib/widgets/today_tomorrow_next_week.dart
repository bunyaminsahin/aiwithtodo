import 'package:flutter/material.dart';

class TodayTomorrowNextWeekWidget extends StatefulWidget {
  const TodayTomorrowNextWeekWidget({super.key, required this.time});

  final String time;

  @override
  State<TodayTomorrowNextWeekWidget> createState() =>
      _TodayTomorrowNextWeekWidgetState();
}

class _TodayTomorrowNextWeekWidgetState
    extends State<TodayTomorrowNextWeekWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFF3DFFE3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.time,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 14,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
