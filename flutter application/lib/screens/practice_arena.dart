import 'package:animate_do/animate_do.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class PracticeArena extends StatefulWidget {
  final questions;

  const PracticeArena({Key? key, this.questions}) : super(key: key);
  @override
  _PracticeArenaState createState() => _PracticeArenaState();
}

class _PracticeArenaState extends State<PracticeArena>
    with TickerProviderStateMixin {
  int _questionNumber = 0;
  final _countDown = CountDownController();
  int _score = 0;

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
                  duration: 10,
                  initialDuration: 0,
                  controller: _countDown,
                  width: 100,
                  height: 100,
                  ringColor: Color(0xff160d20),
                  fillColor: Color(0xffcfb34e),
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
                    setState(() {
                      if (_questionNumber < 9) {
                        _getNextQuestion();
                      }
                    });
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            left: MediaQuery.of(context).size.width / 6 - 24,
            width: MediaQuery.of(context).size.width / 2,
            child: FadeInUp(
              child: Text(
                'Q${_questionNumber + 1}: ${widget.questions[_questionNumber]['question']}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          for (var i = 0;
              i < widget.questions[_questionNumber]['answers'].length;
              i++)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 + i * 50,
              left: 0,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: FadeIn(
                    delay: Duration(seconds: i + 1),
                    child: TextButton(
                      onPressed: () => _checkAnswer(i),
                      child: Text(
                        '${widget.questions[_questionNumber]['answers'][i]}',
                        style: TextStyle(fontSize: 28, color: Colors.white),
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

  _checkAnswer(int? answerIndex) {
    print(answerIndex);
    if (answerIndex != null) {
      if (widget.questions[_questionNumber]['correct_answer'] ==
          _alphaNumeric(answerIndex + 1)) {
        _score++;
      }
      if (_questionNumber != 9) {
        _getNextQuestion();
      } else { 
      }
    }
  }

  _getNextQuestion() {
    setState(() => _questionNumber++);
    _countDown.restart();
  }

  _alphaNumeric(int? index) {
    switch (index) {
      case 1:
        return 'A';
      case 2:
        return 'B';
      case 3:
        return 'C';
      case 4:
        return 'D';
      case 5:
        return 'E';
      case 6:
        return 'F';
    }
  }
}
