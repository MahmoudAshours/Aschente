import 'dart:convert';
import 'dart:math';

import 'package:aschente/screens/practice_arena.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class QuestionsPreparations extends StatelessWidget {
  final subject;
  List _pickedQuestions = [];
  QuestionsPreparations({Key? key, @required this.subject}) : super(key: key);

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
          FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/$subject.json'),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data != null ||
                  snapshot.connectionState == ConnectionState.done) {
                List _questions = json.decode(snapshot.data.toString());
                for (var i = 0; i < 10; i++) {
                  final random = Random().nextInt(_questions.length);
                  _pickedQuestions.add(_questions[random]);
                }
                Future.microtask(
                  () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) =>
                          PracticeArena(questions: _pickedQuestions),
                    ),
                  ),
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: SpinKitCircle(color: Colors.pink),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        child: Text(
                          'Preparing your questions',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
