import 'dart:async';
import 'package:flutter/material.dart';

class CountdownClock extends StatefulWidget {
  const CountdownClock({super.key});

  @override
  State<CountdownClock> createState() => _CountdownClockState();
}

class _CountdownClockState extends State<CountdownClock> {
  DateTime nextFridayMidnight() {
    final now = DateTime.now();
    final daysUntilFriday = (DateTime.friday - now.weekday + 7) % 7;
    final next = now.add(Duration(days: daysUntilFriday));
    return DateTime(next.year, next.month, next.day); // midnight
  }
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {}); // Update the UI every second
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime friday = nextFridayMidnight();
    Duration countdown = friday.difference(DateTime.now());

    int days = countdown.inDays;
    int hours = countdown.inHours % 24;
    int minutes = countdown.inMinutes % 60;
    int seconds = countdown.inSeconds % 60;

    String formattedString = DateTime.now().weekday == DateTime.friday ?
    'IT IS FRIDAY' : '$days days, $hours hours, $minutes minutes, $seconds seconds';

    double screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = screenWidth < 600
        ? screenWidth // phones
        : screenWidth < 1200
            ? screenWidth * 0.5 // tablets/small desktops
            : 700.0; // max cap on large desktops

    return Container(
      width: maxWidth,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          formattedString,
          style: TextStyle(fontSize: 100),
        )  
      )
    )
;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}