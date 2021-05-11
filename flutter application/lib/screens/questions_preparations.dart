import 'dart:convert';
import 'dart:math';

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
          FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/$subject.json'),
            builder: (context, snapshot) {
              List _questions = json.decode(snapshot.data.toString());
              for (var i = 0; i < 10; i++) {
                final random = Random().nextInt(_questions.length - 1);
                _pickedQuestions.add(_questions[random]);
              }
              return Container(
                child: SpinKitCircle(color: Colors.pink),
              );
            },
          ),
        ],
      ),
    );
  }
}
