import 'package:flutter/material.dart';
import 'package:friday/widgets/countdown_clock.dart';
import 'package:friday/widgets/video_player.dart';
import 'dart:async';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Timer? _timer;
  bool isFriday = DateTime.now().weekday == DateTime.friday;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      // Transition into Friday
      if (DateTime.now().weekday == DateTime.friday && !isFriday) {
        isFriday = true;
        setState(() {});
      // Transition out of Friday
      } else if (DateTime.now().weekday != DateTime.friday && isFriday) {
        isFriday = false;
        setState(() {});
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = (screenWidth * 0.08).clamp(18.0, 48.0);

    Widget display = DateTime.now().weekday == DateTime.friday
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'IT IS FRIDAY! 🍻',
                style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              VideoPlayerScreen(),
              Text(
                'TAP VIDEO TO UNMUTE',
                style: TextStyle(fontSize: titleFontSize * 0.4, fontStyle: FontStyle.italic),
              ),
            ],
          )

        : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Countdown to Friday 🍻',
                  style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                CountdownClock(),
                SizedBox(height: 20),
              ],
            );

    return MaterialApp(
      title: 'Friday Countdown',
      home: Scaffold(
        body: Center(
          child:
            display
        )
      ),
    );
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
