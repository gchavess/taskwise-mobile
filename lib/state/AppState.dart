import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  String _userName = '';

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  String getUserName() {
    return _userName;
  }
}
