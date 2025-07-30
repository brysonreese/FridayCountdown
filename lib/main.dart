import 'package:flutter/material.dart';
import 'package:friday/widgets/countdown_clock.dart';
import 'package:friday/widgets/video_player.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = (screenWidth * 0.08).clamp(18.0, 48.0);

    return MaterialApp(
      title: 'Friday Countdown',
      home: Scaffold(
        body: Center(
          child:
            Column(
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
            ),
        )
      ),
    );
  }
}
