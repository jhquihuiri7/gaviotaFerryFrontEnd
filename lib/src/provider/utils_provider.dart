import 'package:flutter/material.dart';

class UtilsProvider extends ChangeNotifier {

  bool _addUserButton = true;
  bool get addUserButton => _addUserButton;
  set addUserButton(bool value) {
    _addUserButton = value;
    notifyListeners();
  }

}