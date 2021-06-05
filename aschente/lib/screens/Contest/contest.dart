import 'package:aschente/helpers/strings.dart';
import 'package:aschente/screens/Contest/start_contest.dart';
import 'package:flutter/material.dart';
import 'package:aschente/widgets/no_glow_behavior.dart';

class Contest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: ListView(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 200,
                      height: 100,
                      child: Text(
                        'This feature is not finished yet',
                        style: TextStyle(color: Colors.white, fontSize: 29),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ...Strings.subjects
            //     .map(
            //       (subject) => GestureDetector(
            //         onTap: () {
            //           Navigator.of(context).push(
            //             MaterialPageRoute(
            //               builder: (_) => StartContest(subject: subject),
            //             ),
            //           );
            //         },
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Hero(
            //               tag: '$subject',
            //               child: Container(
            //                 width: MediaQuery.of(context).size.width / 2,
            //                 height: MediaQuery.of(context).size.height / 4,
            //                 child: Image.asset(
            //                   'assets/$subject.png',
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Text(
            //                 '$subject',
            //                 style: TextStyle(color: Colors.white, fontSize: 20),
            //               ),
            //             ),
            //             Divider()
            //           ],
            //         ),
            //       ),
            //     )
            //     .toList(),
          ],
        ),
      ),
    );
  }
}
