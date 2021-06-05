import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:core';

class ClockTicker extends StatefulWidget {
  final int countDownNumber;
  ClockTicker(this.countDownNumber);
  @override
  _ClockTickerState createState() => _ClockTickerState();
}

class _ClockTickerState extends State<ClockTicker> {
  List numberOfBlocks = [];
  late Timer _timer;
  final firstColor = Color(0xffeacf6d);
  final secondColor = Color(0xff160d20);
  late int counter;
  @override
  void initState() {
    counter = widget.countDownNumber + 1;
    _updateTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: blocks(counter));
  }

  void _updateTime() {
    if (counter != 0) {
      setState(() {
        counter--;
        _timer = Timer(
          Duration(seconds: 2),
          _updateTime,
        );
      });
    }
  }

  Widget blocks(digit) {
    List digitLocations = _numberBlocks(digit.toString());
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 7,
          height: 400,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 4),
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 10,
                offset: Offset(30, 0),
              )
            ],
          ),
          child: GridView(
            children: [
              for (var index = 0; index < 15; index++)
                AnimatedContainer(
                  duration: Duration(milliseconds: index * 140),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: digitLocations.contains(index)
                        ? secondColor
                        : firstColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 1,
                        color: secondColor,
                      ),
                    ],
                    border: Border.all(
                      color: digitLocations.contains(index)
                          ? firstColor
                          : secondColor,
                      width: 0.3,
                      style: BorderStyle.solid,
                    ),
                  ),
                )
            ],
            addAutomaticKeepAlives: false,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          ),
        ),
      ),
    );
  }

  _numberBlocks(String digit) {
    numberOfBlocks.clear();
    switch (digit) {
      case '0':
        numberOfBlocks.addAll([0, 1, 2, 3, 5, 6, 8, 9, 11, 12, 13, 14]);
        break;
      case '1':
        numberOfBlocks.addAll([1, 4, 7, 10, 13]);
        break;
      case '2':
        numberOfBlocks.addAll([0, 1, 2, 5, 6, 7, 8, 9, 12, 13, 14]);
        break;
      case '3':
        numberOfBlocks.addAll([0, 1, 2, 5, 6, 7, 8, 11, 12, 13, 14]);
        break;
      case '4':
        numberOfBlocks.addAll([0, 3, 5, 6, 7, 8, 11, 14]);
        break;
      case '5':
        numberOfBlocks.addAll([0, 1, 2, 3, 6, 7, 8, 11, 12, 13, 14]);
        break;
      case '6':
        numberOfBlocks.addAll([0, 1, 2, 3, 6, 7, 8, 9, 11, 12, 13, 14]);
        break;
      case '7':
        numberOfBlocks.addAll([0, 1, 2, 5, 8, 11, 14]);
        break;
      case '8':
        numberOfBlocks.addAll([0, 1, 2, 3, 5, 6, 7, 8, 9, 11, 12, 13, 14]);
        break;
      case '9':
        numberOfBlocks.addAll([0, 1, 2, 3, 5, 6, 7, 8, 11, 14]);
        break;
      case ':':
        numberOfBlocks.addAll([4, 10]);
        break;
      default:
    }
    return numberOfBlocks;
  }
}
