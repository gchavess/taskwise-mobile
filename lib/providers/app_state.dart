import 'package:flutter/foundation.dart';

class AppProviderState with ChangeNotifier {
  String _userName = '';

  String get userName => _userName;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }
}
