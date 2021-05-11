import 'package:animate_do/animate_do.dart';
import 'package:aschente/helpers/utils.dart';
import 'package:aschente/screens/Practice/practice_result.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ContestArena extends StatefulWidget {
  final Future<DocumentSnapshot> contestId;

  const ContestArena({Key? key, required this.contestId}) : super(key: key);
  @override
  _ContestArenaState createState() => _ContestArenaState();
}

class _ContestArenaState extends State<ContestArena> {
  int _score = 0;
  int _questionNumber = 0;
  List<String> _userAnswers = [];
  FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  final _countDown = CountDownController();

  @override
  void initState() {
    print(widget.contestId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: widget.contestId,
        builder: (c, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState != ConnectionState.done ||
              !snapshot.hasData ||
              snapshot.data == null) {
            Stack(
              children: [
                buildBackground(),
                Container(child: SpinKitCircle(color: Colors.pink)),
              ],
            );
          }
          return Stack(
            children: [
              buildBackground(),
              buildCounter(),
              buildQuestion(context, snapshot.data?.get('questions')),
              ...buildAnswers(
                  context,
                  snapshot.data!.get('questions')[_questionNumber]['answers'],
                  snapshot.data!.get('questions')[_questionNumber])
            ],
          );
        },
      ),
    );
  }

  List<Positioned> buildAnswers(BuildContext context, Map data, egaba) {
    return data
        .map(
          (i, snapshot) => MapEntry(
            i,
            Positioned(
              top: MediaQuery.of(context).size.height / 2 + int.parse(i) * 50,
              left: 0,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: FadeIn(
                    delay: Duration(seconds: i + 1),
                    child: TextButton(
                      onPressed: () => _checkAnswer(
                        snapshot['answers'][i],
                        i,
                        egaba['correct_answer'],
                      ),
                      child: Text(
                        '${snapshot['answers'][i]}',
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
        .values
        .toList();
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

  Positioned buildQuestion(BuildContext context, data) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 3,
      left: MediaQuery.of(context).size.width / 6 - 24,
      width: MediaQuery.of(context).size.width / 2,
      child: FadeInUp(
        child: Text(
          'Q${_questionNumber + 1}: ${data[_questionNumber]['question']}',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  _checkAnswer(String answer, int? answerIndex, correctAnswer) {
    if (answerIndex != null) {
      if (correctAnswer == Utils.alphaNumeric(answerIndex + 1)) {
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
