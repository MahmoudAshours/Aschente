import 'package:flutter/material.dart';

import '../helpers/strings.dart';

class StartPractice extends StatefulWidget {
  final subject;

  const StartPractice({Key key, this.subject}) : super(key: key);

  @override
  _StartPracticeState createState() => _StartPracticeState();
}

class _StartPracticeState extends State<StartPractice> {
  double _height = 0.0;

  @override
  void didChangeDependencies() {
    setState(() {
      _height = MediaQuery.of(context).size.height / 1.9;
    });
    super.didChangeDependencies();
  }

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
          Hero(
            tag: '${widget.subject}',
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: Image.asset(
                'assets/${widget.subject}.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              width: MediaQuery.of(context).size.width,
              height: _height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color(0xff2a1434),
                    Color(0xff160d20),
                    Color(0xff142332)
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Container(
                      child: RichText(
                        text: TextSpan(
                          text: "${widget.subject}",
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 9),
                      child: Container(
                        child: Text(
                          "${Strings.subjectsDesc[widget.subject]}",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Start',
                          style: TextStyle(
                              color: Color(0xffcfb34e),
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              duration: Duration(milliseconds: 300),
            ),
          )
        ],
      ),
    );
  }
}
