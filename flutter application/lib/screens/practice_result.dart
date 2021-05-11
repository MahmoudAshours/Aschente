import 'package:aschente/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class PracticeResult extends StatelessWidget {
  final finalScore;
  final questions;
  final userAnswers;
  const PracticeResult(
      {Key? key, this.finalScore, this.questions, this.userAnswers})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: Swiper(
                itemCount: questions.length,
                itemBuilder: (BuildContext context, i) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          '${questions[i]['question']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Text(
                        'Correct answer is : ${questions[i]['answers'][Utils.reverseAlphaNumeric(questions[i]['correct_answer']) - 1]}',
                      ),
                      Text('Your answer was : ${userAnswers[i]}'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            child: SafeArea(
              child: Container(
                child: Text('$finalScore'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
