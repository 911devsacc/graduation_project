import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _studentNumber = "";

  String get studentNumber => _studentNumber;

  void setStudentNumber(String number) {
    _studentNumber = number;
    notifyListeners();
  }
}
