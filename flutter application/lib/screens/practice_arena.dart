import 'package:animate_do/animate_do.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class PracticeArena extends StatefulWidget {
  @override
  _PracticeArenaState createState() => _PracticeArenaState();
}

class _PracticeArenaState extends State<PracticeArena> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [
                  Color(0xff2a1434),
                  Color(0xff160d20),
                  Color(0xff142332)
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: CircularCountDownTimer(
                  duration: 60,
                  initialDuration: 0,
                  controller: CountDownController(),
                  width: 100,
                  height: 100,
                  ringColor: Color(0xff160d20),
                  ringGradient: null,
                  fillColor: Color(0xffcfb34e),
                  fillGradient: null,
                  backgroundColor: Color(0xff160d20),
                  strokeWidth: 10.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                      fontSize: 33.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: true,
                  onComplete: () {
                    print('Countdown Ended');
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            left: MediaQuery.of(context).size.width / 6 - 24,
            child: FadeInUp(
              child: Text(
                'Q1: What is operating system?',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          for (var i = 0; i < 4; i++)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 + i * 50,
              left: 0,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SlideInLeft(
                    delay: Duration(seconds: i + 1),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        '${i + 1}. sad',
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
