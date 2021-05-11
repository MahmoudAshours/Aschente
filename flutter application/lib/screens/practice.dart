import 'package:aschente/helpers/strings.dart';
import 'package:aschente/screens/start_practice.dart';
import 'package:flutter/material.dart';

import '../widgets/no_glow_behavior.dart';

class Practice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: ListView(
          children: Strings.subjects
              .map(
                (subject) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => StartPractice(subject: subject),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: '$subject',
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 4,
                          child: Image.asset(
                            'assets/$subject.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '$subject',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Divider()
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
