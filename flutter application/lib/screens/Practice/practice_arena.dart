import 'package:animate_do/animate_do.dart';
import 'package:aschente/helpers/utils.dart';
import 'package:aschente/screens/Practice/practice_result.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class PracticeArena extends StatefulWidget {
  final questions;

  const PracticeArena({Key? key, this.questions}) : super(key: key);
  @override
  _PracticeArenaState createState() => _PracticeArenaState();
}

class _PracticeArenaState extends State<PracticeArena> {
  int _questionNumber = 0;
  final _countDown = CountDownController();
  int _score = 0;
  List<String> _userAnswers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),
          buildCounter(),
          buildQuestion(context),
          Divider(),
          for (var i = 0;
              i < widget.questions[_questionNumber]['answers'].length;
              i++)
            buildAnswers(context, i)
        ],
      ),
    );
  }

  Positioned buildAnswers(BuildContext context, int i) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 + i * 80,
      left: 0,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: FadeIn(
            delay: Duration(seconds: i + 1),
            child: TextButton(
              onPressed: () => _checkAnswer(
                  widget.questions[_questionNumber]['answers'][i], i),
              child: Container(
                width: 300,
                child: Text(
                  '${widget.questions[_questionNumber]['answers'][i]}',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          colors: [Color(0xff2a1434), Color(0xff160d20), Color(0xff142332)],
        ),
      ),
    );
  }

  SafeArea buildCounter() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topRight,
          child: CircularCountDownTimer(
            duration: 60,
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
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.MM_SS,
            isReverse: true,
            isReverseAnimation: true,
            isTimerTextShown: true,
            autoStart: true,
            onComplete: () {
              setState(
                () {
                  if (_questionNumber < 9) {
                    _getNextQuestion();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Positioned buildQuestion(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 4.6,
      left: MediaQuery.of(context).size.width / 6 - 24,
      width: MediaQuery.of(context).size.width / 2,
      child: FadeInUp(
        child: Text(
          'Q${_questionNumber + 1}: ${widget.questions[_questionNumber]['question']}',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  _checkAnswer(String answer, int? answerIndex) {
    print(answerIndex);
    if (answerIndex != null) {
      if (widget.questions[_questionNumber]['correct_answer']
              .toString()
              .toUpperCase() ==
          Utils.alphaNumeric(answerIndex + 1)) {
        _score++;
      }
      _userAnswers.add(answer);
      if (_questionNumber != 9) {
        _getNextQuestion();
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => PracticeResult(
              finalScore: _score,
              questions: widget.questions,
              userAnswers: _userAnswers,
            ),
          ),
        );
      }
    }
  }

  _getNextQuestion() {
    setState(() => _questionNumber++);
    _countDown.restart();
  }
}
