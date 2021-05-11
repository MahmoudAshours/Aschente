import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';

class Utils {
  static provider(BuildContext context, {bool listen: false}) =>
      Provider.of<AuthProvider>(context, listen: listen);

  static alphaNumeric(int? index) {
    switch (index) {
      case 1:
        return 'A';
      case 2:
        return 'B';
      case 3:
        return 'C';
      case 4:
        return 'D';
      case 5:
        return 'E';
      case 6:
        return 'F';
    }
  }

  static reverseAlphaNumeric(String? alpha) {
    switch (alpha) {
      case 'A':
        return 1;
      case 'B':
        return 2;
      case 'C':
        return 3;
      case 'D':
        return 4;
      case 'E':
        return 5;
      case 'F':
        return 6;
    }
  }
}
