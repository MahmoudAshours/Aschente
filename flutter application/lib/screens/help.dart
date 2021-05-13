import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width / 5,
      top: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: Container(
          width: 300,
          height: 100,
          child: Center(
            child: Text(
              'If you faced any problems please email it at mashour365@gmail.com',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }
}
