import 'package:aschente/screens/Contest/contest.dart';
import 'package:aschente/screens/help.dart';
import 'package:aschente/screens/Practice/practice.dart';
import 'package:aschente/widgets/gradient_arclight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final List _screens = List.unmodifiable(
    [
      Contest(),
      Practice(),
      Help(),
    ],
  );
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  Color(0xff2a1434),
                  Color(0xff160d20),
                  Color(0xff142332)
                ],
              ),
            ),
          ),
            _screens[_selectedIndex],
          buildGradientArcLight()
        ],
      ),
    );
  }

  GradientArcLight buildGradientArcLight() {
    return GradientArcLight(
      currentIndex: _selectedIndex,
      onItemPressed: (i) => setState(() => _selectedIndex = i),
      buttons: [
        ButtonData(
          FaIcon(
            FontAwesomeIcons.signal,
            color: _selectedIndex != 0 ? Color(0xff55516e) : Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Contest',
              style: TextStyle(
                color: _selectedIndex != 0 ? Color(0xff55516e) : Colors.black,
              ),
            ),
          ),
        ),
        ButtonData(
          FaIcon(
            FontAwesomeIcons.book,
            color: _selectedIndex != 1 ? Color(0xff55516e) : Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Practice',
              style: TextStyle(
                color: _selectedIndex != 1 ? Color(0xff55516e) : Colors.black,
              ),
            ),
          ),
        ),
        ButtonData(
          FaIcon(
            FontAwesomeIcons.question,
            color: _selectedIndex != 2 ? Color(0xff55516e) : Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Help',
              style: TextStyle(
                  color:
                      _selectedIndex != 2 ? Color(0xff55516e) : Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
